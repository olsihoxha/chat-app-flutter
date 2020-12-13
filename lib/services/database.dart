import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username) async {
        return await FirebaseFirestore.instance.collection("users")
            .where("name",isEqualTo: username)
            .get();
  }

  getUserByUseremail(String useremail) async {
    return await FirebaseFirestore.instance.collection("users")
        .where("email",isEqualTo: useremail)
        .get();
  }

  uploadUserInfo(userMap){
      FirebaseFirestore.instance.collection("users")
          .add(userMap).catchError((error){
            print("The error is ${error.toString()}");
      });
  }

  createRoom(String chatRoomId,chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom")
    .doc(chatRoomId)
    .set(chatRoomMap)
    .catchError((error){
      print("The error is ${error.toString()}");
    });
  }

 addConversationMessages(String chatRoomId,messageMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((error){
          print(error.toString());
    });
 }

 getConversationMessages(String chatRoomId) async{
   return FirebaseFirestore.instance.collection("ChatRoom")
       .doc(chatRoomId)
       .collection("chats")
       .orderBy("time",descending: false)
       .snapshots();
 }

 getChatRoom(String username) async{
    return FirebaseFirestore.instance
           .collection("ChatRoom")
           .where("users",arrayContains: username)
           .snapshots();
 }

}