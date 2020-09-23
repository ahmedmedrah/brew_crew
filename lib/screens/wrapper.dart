import 'package:flutter/material.dart';
import 'package:rew_crew/screens/authenticate/authenticate.dart';
import 'package:rew_crew/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return home or authenticae widget
    return Authenticate();
  }
}