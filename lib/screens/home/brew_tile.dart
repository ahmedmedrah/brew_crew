import 'package:flutter/material.dart';
import 'package:rew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final BrewModel brewModel;
  BrewTile({this.brewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brewModel.strength],            
          ),
          title: Text(brewModel.name),
          subtitle: Text('Takes ${brewModel.sugars} sugar(s)'),
        ),
      ),
    );
  }
}