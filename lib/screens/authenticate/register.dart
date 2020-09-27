import 'package:flutter/material.dart';
import 'package:rew_crew/services/auth.dart';
import 'package:rew_crew/shared/constants.dart';
import 'package:rew_crew/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String pass = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        actions: [
          FlatButton.icon(
            onPressed: ()=> widget.toggleView(),
            icon: Icon(Icons.person),
            label: Text('Sign In')
          )
        ],
        title: Text('Sign Up to Brew Crew'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Email'),
                validator: (val)=> val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Password'),
                obscureText: true,
                validator: (val)=> val.length < 6 ? 'Enter a Password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() {
                    pass = val;
                  });
                },
              ),
              SizedBox(height:20),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, pass);
                    if(result == null){
                      setState(() {
                        loading = false;
                        error = 'please supply a valid info';
                      });
                    }
                  }
                },
              ),
              SizedBox(height:20),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}