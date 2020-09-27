import 'package:firebase_auth/firebase_auth.dart';
import 'package:rew_crew/models/user_model.dart';
import 'package:rew_crew/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //create usermodel object based on firebase user
  UserModel _userModelFromFirebaseUser(User user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModel> get user{
    return _auth.authStateChanges().map(_userModelFromFirebaseUser); 
      //.map((User user) => _userModelFromFirebaseUser(user));
  }  

  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userModelFromFirebaseUser(user);
    }catch(e){
      print(e.tostring);
      return null;
    }
  }

  //sign in email/pass
  Future signInWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userModelFromFirebaseUser(user);   
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email/pass
  Future registerWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //create a new document for the new user with the user id
      await DatabaseService(uid :user.uid).updateUserData(sugars: '0',name:'new crew member', strength:100);
      
      return _userModelFromFirebaseUser(user);   
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}