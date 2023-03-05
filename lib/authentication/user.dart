import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class User_Fire
{
  final String uid;
  final String? username;
  final List<dynamic>? favouritesId;
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  User_Fire( {required this.username, required this.uid, required this.favouritesId});

  static String generateRandomId() {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String charsList =
    List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join();
    return '${DateTime.now().millisecondsSinceEpoch}$charsList';
  }

  Future<void> addUserToFirestore(String? idDoc) async {
    String id;
    if(idDoc!=null)
    {
      id = idDoc;
    }
    else{
      id = generateRandomId();
    }
    await usersRef.doc(id).set({
      'name': username,
      'userUID':uid,
      'favouritesId': []
    });
  }


}