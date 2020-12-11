import 'package:flutter/material.dart';
import 'package:tchat/widgets/widget.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-100,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: textFieldStyle(),
                  decoration:textFieldInputDecoration("email")
                ),
                TextField(
                  style: textFieldStyle(),
                  decoration: textFieldInputDecoration("password")
                ),
                SizedBox(height:10),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Text("Forgot Password?",
                    style: textFieldStyle(),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(30) ,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ]
                    )
                  ),
                  child: Text("Sign In",
                  style:  TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:BorderRadius.circular(30)
                  ),
                  child: Text("Sign In with Google",
                    style:  TextStyle(
                        color: Colors.black,
                        fontSize: 17
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                    style: textFieldStyle(),
                    ),
                    SizedBox(width:6),
                    Text("Register now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
