
import 'package:firebase_database/firebase_database.dart';
import 'package:criber/models/contract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:criber/auth.dart';


class ContractManagement {
  ContractManagement();

  final auth = new Auth();
  final contractDatabaseReference = FirebaseDatabase.instance.reference().child("contract");

  Future<Contract> getContractData() async {

    FirebaseUser authUser = await auth.getCurrentUser();
    DataSnapshot snapshot = await contractDatabaseReference.child('user').child(authUser.uid).once();

    return new Contract.fromSnapShot(snapshot);
  }
}
