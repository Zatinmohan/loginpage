import 'package:LoginPage/model/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var _formKey = GlobalKey<FormState>(); //To get the form state
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('data'); //Reference to the database

  String usernameValidator(String value) {
    if (value.isEmpty)
      return "Please enter the username";
    else if (value.length < 3) return "Try another username";
    return null;
  }

  String nameValidator(String value) {
    if (value.isEmpty)
      return "Please enter the name";
    else if (value.contains(new RegExp(r'[0-9]'))) return 'Enter a valid name';
    return null;
  }

  String emailValidator(String value) {
    if (value.isEmpty)
      return "Please enter Email";
    else if (!value.contains('@') || !value.contains('.'))
      return "Please enter a valid email";
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty)
      return 'Please enter the password';
    else if (value.length < 3) return 'Password is not strong ';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffc5e3f6),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 25.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text("Join the revolution",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  nameBuilder(), //Name TextField
                  emailBuilder(), //Email TextField
                  usernameBuilder(), //username Textfield
                  passwordBuilder(), //Password Textfield
                  signupButton(context), //Signup Button
                  BelowSignup(), //Rest other functionality
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container signupButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 18.0),
      height: 50.0,
      child: RaisedButton(
        color: Color(0xff5486f5),
        textColor: Colors.white,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            context
                .read<AuthenticationService>()
                .signUp(
                  email: _emailController.text.trim(),
                  password: _password.text.trim(),
                  username: _username.text.trim(),
                  name: _nameController.text.trim(),
                )
                .whenComplete(() => Navigator.pop(context));
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Text(
          "Sign up",
          style: TextStyle(
            fontSize: 19.0,
          ),
        ),
      ),
    );
  }

  Container passwordBuilder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        validator: passwordValidator,
        controller: _password,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          labelText: "password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.vpn_key),
        ),
      ),
    );
  }

  Container usernameBuilder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        validator: usernameValidator,
        controller: _username,
        decoration: InputDecoration(
          hintText: "Username",
          labelText: "username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.contact_page),
        ),
      ),
    );
  }

  Container emailBuilder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        validator: emailValidator,
        controller: _emailController,
        decoration: InputDecoration(
          hintText: "Email",
          labelText: "email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.email),
        ),
      ),
    );
  }

  Container nameBuilder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        validator: nameValidator,
        controller: _nameController,
        decoration: InputDecoration(
          hintText: "Full Name",
          labelText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.person),
        ),
      ),
    );
  }
}

class BelowSignup extends StatelessWidget {
  const BelowSignup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: "Already have an account? ",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
      TextSpan(
          text: "Login",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16.5,
            fontWeight: FontWeight.w400,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pop(context);
            }),
    ]));
  }
}
