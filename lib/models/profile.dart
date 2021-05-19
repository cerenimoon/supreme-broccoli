import 'package:kan_bagisi/models/model.dart';

// Model kısmı firebaseye kayıt edeceğimiz nesneyi ana hatlarıyla tanımladığım yer
// burda ben örnek olması amaçlı field1, field2 verdim
class Profile extends Model {
  String name;
  String surname;
  String phone;
  String address;
  String bloodGroup;
  String tokenID;
  String userID;

  Profile() : super(Profile.fromMap);

  static Profile fromMap(String documentID, Map<String, dynamic> map) {
    return Profile()
      ..documentID = documentID
      ..name = map["name"]
      ..surname = map["surname"]
      ..phone = map["phone"]
      ..address = map["address"]
      ..bloodGroup = map["bloodGroup"]
      ..tokenID = map["tokenID"]
      ..userID = map["userID"];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "surname": surname,
      "phone": phone,
      "address": address,
      "bloodGroup": bloodGroup,
      "tokenID": tokenID,
      "userID": userID
    };
  }

  @override
  bool isValid() {
    // TODO: implement isValid
    return this.documentID != null;
  }

  String get fullname => this.isValid() ? this.name + " " + this.surname : null;
}
