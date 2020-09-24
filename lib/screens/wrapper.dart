import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rew_crew/models/user_model.dart';
import 'package:rew_crew/screens/authenticate/authenticate.dart';
import 'package:rew_crew/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    //return home or authenticae widget
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}