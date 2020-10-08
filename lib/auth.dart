import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'base_auth.dart';

class Auth implements BaseAuth {
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  Future<String> getCurrentUserToken() async {
    FirebaseUser user = await getCurrentUser();
    return await user.getIdToken();
  }
}
