import 'package:kan_bagisi/models/model.dart';

class Contact extends Model {
  String email;
  String message;
  String userID;

  Contact() : super(Contact.fromMap);

  static Contact fromMap(String documentID, Map<String, dynamic> map) {
    return Contact()
      ..documentID = documentID
      ..email = map["email"]
      ..userID = map["message"]
      ..message = map["message"];
  }

  @override
  Map<String, dynamic> toMap() {
    return {"email": email, "userID": userID, "message": message};
  }
}
