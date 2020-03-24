import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {

  FirebaseUser user;

  String email,password,mobileno,confirmPassword;
  String finalemail,uid;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up here",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red[800],
        ),

        body: SingleChildScrollView(
          child: Form(
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
                        this.email = value;
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
                        this.password=value;
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

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                      labelText: "Confirm password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Colors.blue
                          )
                      ),
                    ),

                    onChanged: (value){
                      setState(() {
                        this.confirmPassword=value;
                      });
                    },
                    validator: (value){
                      if(value != password){
                        return "Re-write password";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter mobile no.",
                        labelText: "mobile",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: Colors.blue
                            )
                        )
                    ),

                    onChanged: (value){
                      setState(() {
                        this.mobileno=value;
                      });
                    },
                    validator: (value){
                      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = new RegExp(patttern);
                      if(value.length!=10){
                        return "Enter valid mobile no.";
                      }else if (!regExp.hasMatch(value)) {
                        return 'Enter valid mobile number';
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
                  child: Text("SignUp",style: TextStyle(color: Colors.white),),
                  color: Colors.red[800],
                  onPressed: (){
                    signUpUser();
                    print("details added to database : $email ,$password");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

  Future<FirebaseUser> signUpUser() async {
    user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(uid.toString());
    }).catchError((e){
      print(e.toString());
    });
    saveToDatabase(user);
  }

  Future saveToDatabase(FirebaseUser user) async {
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      DocumentReference reference = await firestore.collection("Detail").add({
        'Email': user.email,
        'Mobile no.':mobileno,
        'Password':password,
        'UID':user.uid,
      });
    }
  }

}
