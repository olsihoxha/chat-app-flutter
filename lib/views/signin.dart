import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/helper/helperfunction.dart';
import 'package:tchat/services/auth.dart';
import 'package:tchat/services/database.dart';
import 'package:tchat/widgets/widget.dart';

import 'chatrooms.dart';
class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey =GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool isLoading=false;
  AuthMethod authMethod=AuthMethod();
  DatabaseMethods databaseMethods=DatabaseMethods();



  signIn(){
    if(formKey.currentState.validate()){
      HelperFunction.saveUserEmailSharedPreference(emailController.text);
      databaseMethods.getUserByUseremail(emailController.text).then((value){
        HelperFunction.saveUserNameSharedPreference(value.docs[0].data()['name']);
        print("THIS IS THE USERNAME: " +value.docs[0].data()['name']);
      });
      setState(() {
        isLoading=true;
      });
      authMethod.signInWithEmailAndPassword(emailController.text, passwordController.text)
          .then((value) {
        // print("${value.userId}");
        if(value!=null){
          HelperFunction.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=>ChatRoom(),
        ));
        }
      }).catchError((error){
        print(error.toString());
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
      child: Center(child: CircularProgressIndicator()),
    ) : Scaffold(
        appBar: appbarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-100,
          alignment: Alignment.bottomCenter,
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter correct email";
                      },
                    controller: emailController,
                    style: textFieldStyle(),
                    decoration:textFieldInputDecoration("email")
                  ),
                  TextFormField(
                    obscureText: true,
                      validator: (val){
                        return val.length < 6 ? "Please provide a password 6+ characters":null;
                      },
                    controller: passwordController,
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
                  GestureDetector(
                    onTap: (){
                      signIn();
                    },
                    child: Container(
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
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Register now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline
                            ),
                          ),
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
      ),
    );
  }
}
