import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {

  FirebaseUser user;
  ProfilePage(FirebaseUser user){
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile Page",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[800],),
        body:StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection('Detail').document(user.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasError){
              return Text("Error : ${snapshot.error}");
            }
            switch(snapshot.connectionState){
              case ConnectionState.waiting :
                return Text("Loading...");
              default:
                return Column(
                  children: <Widget>[
                    Text(snapshot.data['Email']),
                    Text(snapshot.data['Mobile no.']),
                    Text(snapshot.data['Password']),
                  ],
                );
            }
          },
        )
    );
  }
}

