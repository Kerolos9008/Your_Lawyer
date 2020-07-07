import 'package:Your_Lawyer/Services/userData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class UserAuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _registerUser(String email,String password) async {

    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await UserDataService(user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
}