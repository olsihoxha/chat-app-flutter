import 'package:flutter/material.dart';
import 'package:tchat/helper/authenticate.dart';
import 'package:tchat/helper/constants.dart';
import 'package:tchat/helper/helperfunction.dart';
import 'package:tchat/services/auth.dart';
import 'package:tchat/views/search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethod authMethod=AuthMethod();
@override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
  Constants.myName=await HelperFunction.getUserNameInSharedPreference();
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
    );
  }
}
