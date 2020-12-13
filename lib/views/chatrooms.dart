import 'package:flutter/material.dart';
import 'package:tchat/helper/authenticate.dart';
import 'package:tchat/helper/constants.dart';
import 'package:tchat/helper/helperfunction.dart';
import 'package:tchat/services/auth.dart';
import 'package:tchat/services/database.dart';
import 'package:tchat/views/search.dart';
import 'package:tchat/widgets/widget.dart';

import 'conversation.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethod authMethod=AuthMethod();
  Stream chatRoomsStream;

  Widget chatRoomList(){
      return StreamBuilder(
          stream: chatRoomsStream,
          builder: (context,snapshot){
            return snapshot.hasData ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context,index){
                  return ChatRoomsTile(
                      snapshot.data.docs[index].data()["chatRoomId"].toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, "")
                 ,snapshot.data.docs[index].data()["chatRoomId"] );
                }
            ): Container();
          }
      );
  }
@override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
  Constants.myName=await HelperFunction.getUserNameInSharedPreference();
  DatabaseMethods().getChatRoom(Constants.myName).then((value){
    setState(() {
      chatRoomsStream=value;
    });
  });
  setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png",height: 50,),
        actions: [
          GestureDetector(
            onTap: (){
              authMethod.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=>Authenticate()
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=> Search()));
        },
        child: Icon(
          Icons.search
        ),
      ),
      body: chatRoomList(),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName,this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>ConversationScreen(chatRoomId)
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Center(
                child: Text(
                  "${userName.substring(0,1).toUpperCase()}"
                ),
              ),
            ),
            SizedBox(width:8),
            Text(
              userName,
              style: textFieldStyle(),
            )
          ],
        ),
      ),
    );
  }
}

