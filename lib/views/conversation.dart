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

  Widget chatMessageList(){

  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,String> messageMap={
        "message":messageController.text,
        "sendBy":Constants.myName
      };
      databaseMethods.getConversationMessages(widget.chatRoomId, messageMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarMain(context),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
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
                        // initiateSearch();
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
