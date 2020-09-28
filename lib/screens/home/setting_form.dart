import 'package:flutter/material.dart';
import 'package:rew_crew/services/database.dart';
import 'package:rew_crew/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:rew_crew/models/user_model.dart';
import 'package:rew_crew/shared/loading.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children:[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText:'Name'),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars,
                  decoration: textInputDecoration,
                  hint: Text('Number of sugars'),
                  items: sugars.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text('$e sugar(s)'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val ),
                ),
                SizedBox(height: 10.0),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value: (_currentStrength ?? userData.strength).toDouble() ,
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  onChanged: (val) {
                    setState(() => _currentStrength = val.round());
                  },            
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        sugars:_currentSugars ?? snapshot.data.sugars, 
                        name: _currentName ?? snapshot.data.name, 
                        strength: _currentStrength ?? snapshot.data.strength
                      );
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          );
        }else{
          return Loading();
        }        
      }
    );
  }  
}