import 'package:flutter/material.dart';
import 'package:tchat/helper/authenticate.dart';
import 'package:tchat/helper/helperfunction.dart';
import 'package:tchat/views/chatrooms.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn=false;

  @override
  void initState() {
    getLoggedInStatus();
    super.initState();
  }

  getLoggedInStatus() async{
    await HelperFunction.getUserLoggedInSharedPreference().then(
            (value){
              setState(() {
                if(value!=null){
                userIsLoggedIn=value;
                }
              });
            }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tchat',
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn ? ChatRoom() : Authenticate() ,
    );
  }
}
