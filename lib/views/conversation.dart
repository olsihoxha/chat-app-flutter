import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tchat/helper/constants.dart';
import 'package:tchat/services/database.dart';
import 'package:tchat/widgets/widget.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods=DatabaseMethods();
  TextEditingController messageController=TextEditingController();
  Stream chatMessagesStream;
  ScrollController _scrollController = ScrollController();
  Widget chatMessageList(){
    Timer(
      Duration(milliseconds: 100),
          () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    );
      return StreamBuilder(
          builder: (context,snapshot){
            return snapshot.hasData ? ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data.docs.length,
                itemBuilder:(context,index) {
                  return MessageTile(snapshot.data.docs[index].data()["message"],
                      snapshot.data.docs[index].data()["sendBy"]==Constants.myName
                  );
                }
            ):Container();
          },
          stream: chatMessagesStream,
      );
  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap={
        "message":messageController.text,
        "sendBy":Constants.myName,
        "time":DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text="";
      Timer(
        Duration(milliseconds: 100),
            () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
      );
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream=value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarMain(context),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 85),
                child: chatMessageList()
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey,
                padding: EdgeInsets.symmetric(vertical:16 ,horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            hintText: "write message...",
                            hintStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                         sendMessage();
                      },
                      child: Container(
                          padding:EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(40)
                          ),
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/send.png",)
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ?0:24,right:isSendByMe ?24:0 ),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        decoration: BoxDecoration(
          borderRadius:isSendByMe ? BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ):BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            colors: isSendByMe?  [
              Color(0xff007EF4),
              Color(0xff2A75BC)
            ] :  [
              Color(0x1AFFFFFF),
              Color(0x1AFFFFFF)
            ],
          )
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17
          ),
        ),
      ),
    );
  }
}

