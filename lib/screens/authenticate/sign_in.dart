import 'package:flutter/material.dart';
import 'package:rew_crew/services/auth.dart';
import 'package:rew_crew/shared/constants.dart';
import 'package:rew_crew/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String pass = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold( // show the loading screen if loading is true
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        actions: [
          FlatButton.icon(
            onPressed: ()=> widget.toggleView(),
            icon: Icon(Icons.person),
            label: Text('Register')
          )
        ],
        title: Text('Sign In to Brew Crew'),
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
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Password'),
                validator: (val)=> val.length < 6 ? 'Enter a Password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => pass = val);
                },
              ),
              SizedBox(height:20),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, pass);
                    if(result == null){
                      setState(() {
                        loading = false;
                        return error = "couldn't sign in with this credentials";
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