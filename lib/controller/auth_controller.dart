import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isLoading = false;

  Stream<User?> stream() => _firebaseAuth.authStateChanges();

  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> logOut() async {
    try {
      await _firebaseAuth.signOut();

      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading = false;

      notifyListeners();

      return Future.value(ex.message);
    }
  }

  Future<String> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      _isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }
}
