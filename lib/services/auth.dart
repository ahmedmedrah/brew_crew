import 'package:firebase_auth/firebase_auth.dart';
import 'package:rew_crew/models/user_model.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //create usermodel object based on firebase user
  UserModel _userModelFromFirebaseUser(User user){
    return user != null ? UserModel(uid: user.uid) : null;
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

  //register email/pass

  //sign out
}