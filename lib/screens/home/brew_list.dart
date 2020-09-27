import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rew_crew/models/brew.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {  
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewModel>>(context);
   
    return ListView.builder(
      
      itemCount: brews.length,
      itemBuilder: (context,index) {
        return BrewTile(brewModel: brews[index]);
      },
    );
  }
}