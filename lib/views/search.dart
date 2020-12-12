import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tchat/helper/constants.dart';
import 'package:tchat/services/database.dart';
import 'package:tchat/views/conversation.dart';
import 'package:tchat/widgets/widget.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController searchController=TextEditingController();
  QuerySnapshot searchSnapshot;

  Widget searchList(){
    return searchSnapshot !=null ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchSnapshot.docs.length,
      itemBuilder: (context,index){
          return SearchTile(
            userName: searchSnapshot.docs[index].data()['name'],
            userEmail: searchSnapshot.docs[index].data()['email'],
          );
        },
    ):Container();
  }

   initiateSearch() {
    DatabaseMethods().getUserByUsername(searchController.text)
        .then((value){
          setState(() {
            searchSnapshot=value;
          });
            });
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(vertical:16 ,horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchController,
                          style: TextStyle(
                            color: Colors.white
                          ),
                          decoration: InputDecoration(
                          hintText: "search username...",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          border: InputBorder.none,
                        ),
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                        padding:EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x3FFFFFFF),
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        height: 40,
                        width: 40,
                        child: Image.asset("assets/search_white.png",)
                    ),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}


  createChatRoomAndStartConversation(String userName,BuildContext context){
  if(userName!=Constants.myName){
    List<String> users=[userName,Constants.myName];
    String chatRoomId =getChatRoomId(userName, Constants.myName);
    Map<String,dynamic> chatRoomMap ={
      "users":users,
      "chatRoomId":chatRoomId
    };
    DatabaseMethods().createRoom(chatRoomId, chatRoomMap);
    Navigator.push(context, MaterialPageRoute(
        builder: (context)=>ConversationScreen(chatRoomId)
    ));
  }else{
    print("You cannot send messages to yourself");
  }
  }

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}


class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  SearchTile({this.userName,this.userEmail});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Text(userName,
                  style:textFieldStyle(),
                  ),
              Text(userEmail,
                style:textFieldStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(userName, context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text("Message",
              style: TextStyle(
                color: Colors.white
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

