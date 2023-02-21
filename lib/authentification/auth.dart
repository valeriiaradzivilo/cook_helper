import 'package:firebase_auth/firebase_auth.dart';

import 'user.dart';

class AuthService
{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void Initialize() async{

  }

  // create user object based on firebase user
  User_Fire? _userFromFirebaseUser(User? user)
  {
    return user!=null? User_Fire(uid: user.uid, username: user.displayName):null;
  }


  //auth change user stream
  Stream<User_Fire?> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
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
  Future registerWithEmailAndPassword(String email, String password)
  async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
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