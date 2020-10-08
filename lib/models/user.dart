import 'package:firebase_database/firebase_database.dart';

class User {
  String _name;
  String _profilePhoto;
  String _currentAddress;
  String _birthday;
  String _workplace;

  User();

  String get name => _name;

  String get profilePhoto => _profilePhoto;

  String get currentAddress => _currentAddress;

  String get birthday => _birthday;

  String get workplace => _workplace;

  User.fromSnapShot(DataSnapshot snapshot) {
    _name = snapshot.value['name'];
    _profilePhoto = snapshot.value['profile_photo'];
    _currentAddress = snapshot.value['current_address'];
    _birthday = snapshot.value['birthday'];
    _workplace = snapshot.value['workplace'];
  }

  toJson() {
    return {
      "name": _name,
      "profile_photo": _profilePhoto,
      "current_address": _currentAddress,
      "birthday": _birthday,
      "workplace": _workplace,
    };
  }
}
