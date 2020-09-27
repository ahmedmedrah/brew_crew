import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rew_crew/models/brew.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  Future updateUserData ({String sugars, String name, int strength}) async {
    return await brewCollection.doc(uid).set({
      'sugars':sugars,
      'name':name,
      'strength':strength
    });
  }

  //get brews stream
  Stream<List<BrewModel>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshop);
  }

  //brewlist for snapshot
  List<BrewModel> _brewListFromSnapshop(QuerySnapshot snapshot){
    return snapshot.docs.map((e) {
      return BrewModel(
        name: e.data()['name'].toString() ?? '',
        sugars: e.data()['sugars'].toString() ?? '0',
        strength: e.data()['strength'] ?? 0
      );
    }).toList();

  }
}