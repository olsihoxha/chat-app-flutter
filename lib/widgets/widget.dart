import 'package:flutter/material.dart';

Widget appbarMain(BuildContext context){
  return AppBar(
    title: Image.asset("assets/logo.png",height: 50,),
  );
}

InputDecoration textFieldInputDecoration(String hint){
  return InputDecoration(
      hintText: hint,
      hintStyle:TextStyle(
          color: Colors.white54
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.cyanAccent),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          )
      )
  );
}

TextStyle textFieldStyle(){
  return TextStyle(
      color: Colors.white,
      fontSize: 16
  );
}