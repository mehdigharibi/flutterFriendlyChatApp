import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //New Isntance of FireBaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//New Instance Of FireStore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//User sign In
  Future<UserCredential> signInWithEP(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

//Add New Document for user in Users Collection if Doesn't Already Exist
      _firestore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email},
          SetOptions(merge: true));

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

//Signout Function
  Future<void> Signout() async {
    return _firebaseAuth.signOut();
  }

  //Signup Function

  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      //Create New Document for user in Users Collection
      _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
