import 'package:authenticationflutter/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email,password,mobileno,finalemail,uid;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login here",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red[800],
        ),

        body: Form(
          key: formkey,
          child: Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter email",
                      labelText: "email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Colors.blue
                          )
                      )
                  ),

                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                  validator: (value){
                    if(value.contains('@') != true){
                      return "Please enter valid email";
                    }else{
                      return null;
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    labelText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                  ),

                  onChanged: (value){
                    setState(() {
                      password=value;
                    });
                  },
                  validator: (value){
                    if(value.length != 8){
                      return "Enter password btw 1-8 characters";
                    }else{
                      return null;
                    }
                  },
                ),
              ),

              SizedBox(height: 40.0,),

              RaisedButton(
                splashColor: Colors.white,
                elevation: 10.0,
                child: Text("Login",style: TextStyle(color: Colors.white),),
                color: Colors.red[800],
                onPressed: (){
                  loginUser();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> loginUser() async {
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      user = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
      ).then((value){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ProfilePage(user)));
        print("SignIn successfully");
      }).catchError((e){
        print(e.toString());
      });
    }
  }
}
