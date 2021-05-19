abstract class Model {
  Model Function(String, Map<String, dynamic>) fromMapFn;

  Model(this.fromMapFn);
  String documentID;
  Map<String, dynamic> toMap();

  bool isValid() {
    return true;
  }

  Model clone() {
    return fromMapFn(documentID, this.toMap());
  }
}
