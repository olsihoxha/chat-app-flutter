import 'package:firebase_auth/firebase_auth.dart';
import 'package:tchat/modal/theuser.dart';

class AuthMethod{
    final FirebaseAuth _auth=FirebaseAuth.instance;
    TheUser _theUserFirebase(User user){
      return user!=null ? TheUser(userId: user.uid) : null;
    }
    Future signInWithEmailAndPassword(String email,String password) async {
      try{
       UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
       User firebaseUser=result.user;
       return _theUserFirebase(firebaseUser);
      }catch(e){
        print(e.toString());
      }
      }

      Future signUpWithEmailAndPassword(String email,String password) async{
        try{
          UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
          User firebaseUser=result.user;
          return _theUserFirebase(firebaseUser);
        }catch(e){
          print(e.toString());
        }
      }

      Future resetPassword (String email) async{
          try{
            return _auth.sendPasswordResetEmail(email: email);
          }catch(e){
            print(e.toString());
          }
      }

      Future signOut() async{
      try{
        return await _auth.signOut();
      }catch(e){
        print(e.toString());
      }
      }
}