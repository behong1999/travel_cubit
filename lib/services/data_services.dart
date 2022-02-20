import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_flutter/models/place.dart';

class DataServices {
  Stream<List<Place>> fetchAll() =>
      FirebaseFirestore.instance.collection('places').snapshots().map(
            (snapshot) =>
                snapshot.docs.map((e) => Place.fromJson(e.data())).toList(),
          );

  Future<Place> fetchDetail(String name) => FirebaseFirestore.instance
      .collection('places')
      .where("name", isEqualTo: name)
      .get()
      .then((snapshot) => Place.fromJson(snapshot.docs[0].data()));
}
