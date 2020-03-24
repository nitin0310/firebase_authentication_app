import 'package:authenticationflutter/loginPage.dart';
import 'package:authenticationflutter/signUpPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                RaisedButton(
                  child: Text("Sign Up",style: TextStyle(color: Colors.white),),
                  elevation: 10.0,
                  color: Colors.red[800],
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                  },
                ),

                RaisedButton(
                  child: Text("Login",style: TextStyle(color: Colors.white),),
                  elevation: 10.0,
                  color: Colors.red[800],
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                ),

              ],
            ),
          ),
        ),
      );
  }
}
