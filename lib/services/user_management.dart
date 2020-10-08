import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:criber/models/user.dart';
import 'package:criber/auth.dart';

class UserManagement {
  UserManagement();

  final auth = new Auth();
  final usersDatabaseReference = FirebaseDatabase.instance.reference().child('users');

  Future<User> getUserData() async {
    FirebaseUser authUser = await auth.getCurrentUser();
    DataSnapshot snapshot = await usersDatabaseReference.child(authUser.uid).once();

    return new User.fromSnapShot(snapshot);
  }
}
