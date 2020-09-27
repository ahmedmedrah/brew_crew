import 'package:flutter/material.dart';
import 'package:rew_crew/models/brew.dart';
import 'package:rew_crew/services/auth.dart';
import 'package:rew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingPanel(){
      showModalBottomSheet(
        context: context, 
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Text('bottom sheet'),
          );
        });
    }

    return StreamProvider<List<BrewModel>>.value(
      value: DatabaseService().brews,
      initialData: List(),
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('Logout'),
            ),
            FlatButton.icon(
              onPressed: () =>_showSettingPanel(),
              icon: Icon(Icons.settings), 
              label: Text('Setting')
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }

  
}