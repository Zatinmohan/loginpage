import 'package:LoginPage/mainpage.dart';
import 'package:LoginPage/model/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Ensure flutter binding with the application
  await Firebase
      .initializeApp(); //Initialize firebase before starting the application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(
                FirebaseAuth.instance), //provide auth service
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
          )
        ],
        child: MaterialApp(
          title: "Login Page",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xffc5e3f6),
            textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme),
          ),
          home: AuthenticationWrapper(),
        ));
  }
}

//Login Behind Already Signed-in
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) return LandPage();

    return Homepage();
  }
}
