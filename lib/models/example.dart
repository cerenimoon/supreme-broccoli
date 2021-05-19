import 'package:kan_bagisi/models/model.dart';

// Model kısmı firebaseye kayıt edeceğimiz nesneyi ana hatlarıyla tanımladığım yer
// burda ben örnek olması amaçlı field1, field2 verdim
class Example extends Model {
  String field1;
  int field2;
  DateTime field3;
  String field4;
  String userID;

  Example() : super(Example.fromMap);

  static Example fromMap(String documentID, Map<String, dynamic> map) {
    return Example()
      ..documentID = documentID
      ..field1 = map["field1"]
      ..field2 = map["field2"]
      ..field3 = map["field3"]
      ..userID = map["userID"]
      ..field4 = map["field4"];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "field1": field1,
      "field2": field2,
      "field3": field3,
      "field4": field4,
      "userID": userID
    };
  }
}
