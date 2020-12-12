import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String sharedPreferencesUserLoggedInKey="ISLOGGEDIN";
  static String sharedPreferencesUserNameKey="USERNAMEKEY";
  static String sharedPreferencesUserEmailKey="USEREMAILKEY";

  //save data
  static Future<void> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
        SharedPreferences prefs=await SharedPreferences.getInstance();
        return await prefs.setBool(sharedPreferencesUserLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUserNameSharedPreference(String userName) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserNameKey, userName);
  }

  static Future<void> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserEmailKey, userEmail);
  }

  //get data
  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesUserLoggedInKey);
  }

  static Future<String> getUserNameInSharedPreference() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserNameKey);
  }

  static Future<String> getUserEmailInSharedPreference() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserEmailKey);
  }


}
