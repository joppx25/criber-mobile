import 'package:firebase_auth/firebase_auth.dart';
abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> getCurrentUser();
}