import 'package:flutter/material.dart';
import 'package:tchat/helper/helperfunction.dart';
import 'package:tchat/services/auth.dart';
import 'package:tchat/services/database.dart';
import 'package:tchat/views/chatrooms.dart';
import 'package:tchat/widgets/widget.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey =GlobalKey<FormState>();
  bool isLoading=false;
  AuthMethod authMethod=AuthMethod();

  TextEditingController userNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  signUp(){
      if(formKey.currentState.validate()){
        Map<String,String> userMap={
          "name": userNameController.text,
          "email":emailController.text
        };
        HelperFunction.saveUserNameSharedPreference(userNameController.text);
        HelperFunction.saveUserEmailSharedPreference(emailController.text);
          setState(() {
            isLoading=true;
          });
          authMethod.signUpWithEmailAndPassword(emailController.text, passwordController.text)
              .then((value) {
                // print("${value.userId}");
                DatabaseMethods().uploadUserInfo(userMap);
                HelperFunction.saveUserLoggedInSharedPreference(true);
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context)=>ChatRoom(),
                ));
          }).catchError((error){
            print(error.toString());
          });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-100,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          validator: (val){
                           return val.isEmpty || val.length <4 ? "Username is not valid" : null;
                          },
                          controller: userNameController,
                          style: textFieldStyle(),
                          decoration:textFieldInputDecoration("username")
                      ),
                      TextFormField(
                          validator: (val){
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter correct email";
                            },
                          controller: emailController,
                          style: textFieldStyle(),
                          decoration:textFieldInputDecoration("email")
                      ),
                      TextFormField(
                        validator: (val){
                          return val.length < 6 ? "Please provide a password 6+ characters":null;
                        },
                          obscureText: true,
                          controller: passwordController,
                          style: textFieldStyle(),
                          decoration: textFieldInputDecoration("password")
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    signUp();
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
                    child: Text("Sign Up",
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
                  child: Text("Sign Up with Google",
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
                    Text("Already have an account?",
                      style: textFieldStyle(),
                    ),
                    SizedBox(width:6),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Sign In",
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
    );
  }
}
