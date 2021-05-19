import 'package:kan_bagisi/models/model.dart';

class BloodDemand extends Model {
  String patientName;
  String patientSurname;
  String patientPhone;
  String patientAddress;
  String patientBloodGroup;
  String userID;

  BloodDemand() : super(BloodDemand.fromMap);

  static BloodDemand fromMap(String documentID, Map<String, dynamic> map) {
    return BloodDemand()
      ..documentID = documentID
      ..patientName = map["patientName"]
      ..patientSurname = map["patientSurname"]
      ..patientPhone = map["patientPhone"]
      ..patientAddress = map["patientAddress"]
      ..patientBloodGroup = map["patientBloodGroup"]
      ..userID = map["userID"];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "patientName": patientName,
      "patientSurname": patientSurname,
      "patientPhone": patientPhone,
      "patientAddress": patientAddress,
      "patientBloodGroup": patientBloodGroup,
      "userID": userID
    };
  }

  @override
  bool isValid() {
    return this.documentID != null;
  }

  String get patientFullname =>
      this.isValid() ? this.patientName + " " + this.patientSurname : null;
}
