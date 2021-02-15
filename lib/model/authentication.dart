import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges =>
      _firebaseAuth.authStateChanges(); //Already Sign-in functionality

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {String name, String email, String username, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //Storing data in firebase

      FirebaseFirestore.instance
          .collection('data')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'name': name,
        'username': username,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  String getCurrentUser() {
    return _firebaseAuth.currentUser.uid;
  }
}
