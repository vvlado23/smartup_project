import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final auth = FirebaseAuth.instance;

class Login {
  static bool isLoggedIn = false;
  final mail;
  final pass;

  Login({required this.mail, required this.pass});
  Login.out({this.mail = " ", this.pass = " "});

  Future<bool> doLoginWithToken() async {
    try {
      await auth.signInWithCustomToken(auth.currentUser!.uid);
      isLoggedIn = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> doLogin() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: mail,
        password: pass,
      );
      isLoggedIn = true;
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<void> doLogout() async {
    try {
      await auth.signOut();
      isLoggedIn = false;
    } on FirebaseAuthException catch (e) {
      return;
    }
  }
}
