import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'user.dart';

class AuthService
{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void Initialize() async{

  }

  // create user object based on firebase user
  Future<User_Fire?> _userFromFirebaseUser(User? user)async
  {
    String name;
    List<dynamic> favouritesId;
    bool isCreator;
    if(user!=null)
      {
        final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
        QuerySnapshot querySnapshot = await usersCollection.get();
        List<QueryDocumentSnapshot> documents = querySnapshot.docs;
        for (QueryDocumentSnapshot document in documents) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          if(data['userUID'] == user.uid)
            {
              name = data['name'];
              favouritesId = data['favouritesId'];
              isCreator = data['isCreator'];
              return User_Fire(username: name, uid: user.uid, favouritesId: favouritesId, isCreator: isCreator);
            }
        }
      }
    return null;
  }




  //auth change user stream
  Stream<User_Fire?> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser as User_Fire? Function(User? event));
  }

  // sign in anon

  Future signInAnon() async
  {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and pas


  //register with email and password
  Future registerWithEmailAndPassword(String email, String password, String username, String? enteredCode
      )
  async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      User_Fire newUser = User_Fire(username: username, uid: user!.uid, favouritesId: [], isCreator: await checkCreator(email, enteredCode));
      newUser.addUserToFirestore(null);
      return _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  Future<bool> checkCreator(String email, String? enteredCode)
  async {
    print("checking code $enteredCode for $email");
    if(enteredCode==null)
      {
        return false;
      }
    else {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('creatorCodes');
      QuerySnapshot querySnapshot = await usersCollection.get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      for (QueryDocumentSnapshot document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        if (data['email'] == email) {
          if (data['code'] == enteredCode) {
            return true;
          }
        }
      }
    }
    return false;
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password)
  async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }




}