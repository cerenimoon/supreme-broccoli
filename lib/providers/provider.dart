import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kan_bagisi/models/model.dart';

class Provider<T extends Model> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String path;
  Model Function(String, Map<String, dynamic>) fromMap;

  Provider({this.path, this.fromMap});

  T _convertToModel(DocumentSnapshot doc) {
    Model entity = fromMap(doc.id, doc.data());
    return entity;
  }

  List<T> _convertToList(List<DocumentSnapshot> docs) =>
      docs.map((doc) => _convertToModel(doc)).toList();

  Future<List<T>> get getAll async =>
      this._convertToList((await db.collection(path).get()).docs);

  Future<T> getBy(String documentID) async =>
      _convertToModel(await db.collection(path).doc(documentID).get());

  Future<List<T>> getListBy(String fieldName,
      {dynamic isEqualTo,
      dynamic isNotEqualTo,
      dynamic isLessThan,
      dynamic isLessThanOrEqualTo,
      dynamic isGreaterThan,
      dynamic isGreaterThanOrEqualTo,
      dynamic arrayContains,
      bool isNull}) async {
    return this._convertToList((await db
            .collection(path)
            .where(fieldName,
                isEqualTo: isEqualTo,
                isLessThan: isLessThan,
                isNotEqualTo: isNotEqualTo,
                isGreaterThan: isGreaterThan,
                isNull: isNull,
                arrayContains: arrayContains,
                isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
                isLessThanOrEqualTo: isLessThanOrEqualTo)
            .get())
        .docs);
  }

  Future<void> delete(String documentID) async =>
      (await db.collection(path).doc(documentID).delete());

  Future<T> update(T model) async {
    Model base = model;
    await db.collection(path).doc(base.documentID).set(base.toMap());
    return base;
  }

  Future<String> save(T model) async {
    Model base = model;
    DocumentReference ref = await db.collection(path).add(base.toMap());
    return ref.id;
  }

  Future<int> get countAll async => (await db.collection(path).get()).size;

  Future<int> countBy(String fieldName,
          {dynamic isEqualTo,
          dynamic isLessThan,
          dynamic isLessThanOrEqualTo,
          dynamic isGreaterThan,
          dynamic isGreaterThanOrEqualTo,
          dynamic arrayContains,
          bool isNull}) async =>
      (await this
              .db
              .collection(path)
              .where(fieldName,
                  isEqualTo: isEqualTo,
                  isLessThan: isLessThan,
                  isGreaterThan: isGreaterThan,
                  isNull: isNull,
                  arrayContains: arrayContains,
                  isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
                  isLessThanOrEqualTo: isLessThanOrEqualTo)
              .get())
          .size;

  Stream<QuerySnapshot> stream(String fieldName,
          {dynamic isEqualTo,
          dynamic isLessThan,
          dynamic isLessThanOrEqualTo,
          dynamic isGreaterThan,
          dynamic isGreaterThanOrEqualTo,
          dynamic arrayContains,
          bool isNull}) =>
      this
          .db
          .collection(path)
          .where(fieldName,
              isEqualTo: isEqualTo,
              isLessThan: isLessThan,
              isGreaterThan: isGreaterThan,
              isNull: isNull,
              arrayContains: arrayContains,
              isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
              isLessThanOrEqualTo: isLessThanOrEqualTo)
          .snapshots();
}
