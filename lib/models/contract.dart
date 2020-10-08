import 'package:firebase_database/firebase_database.dart';

class Contract {
  String _contractNumber;
  String _start_date;
  String _end_date;

  Contract();

  String get contractNumber => _contractNumber;
  String get startDate => _start_date;
  String get endDate => _end_date;

  Contract.fromSnapShot(DataSnapshot snapshot) {
    _contractNumber = snapshot.value['contract_number'].toString();
    _start_date = snapshot.value['start_date'].toString();
    _end_date = snapshot.value['end_date'].toString();
  }

  toJson() {
    return {
      "contract_number": _contractNumber,
      "start_date": _start_date,
      "end_date": _end_date,
    };
  }
}
