import 'package:LoginPage/model/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandPage extends StatefulWidget {
  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  String name = "null";
  String username = "null";
  final userID = FirebaseAuth.instance.currentUser.uid;

  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    FirebaseFirestore.instance
        .collection('data')
        .doc(userID)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        name = ds['name'].toString();
        username = ds['username'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, actions: [
        IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            }),
      ]),
      body: Center(
        child: name == "null"
            ? CircularProgressIndicator()
            : Text(
                "Hey, $name\n Username: $username",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
      ),
    );
  }
}
