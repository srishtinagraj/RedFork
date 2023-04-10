import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Signing Up User
  Future<String?> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          firstName.isNotEmpty ||
          lastName.isNotEmpty) {
        // register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        // add user to database
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'email': email,
          'password': password,
          'first name': firstName,
          'last name': lastName
        });

        res = "success";
      }       
    }
    
    catch (err) {
      res = err.toString();
    }
    return res;
  }
} 

  /* // Logging In User
    Future<String?> loginUser({
      required String email,
      required String password,
    }) async {
      try {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        return null;
      } on FirebaseAuthException catch (e) {
        return e.message;
      } catch (e) {
        return e.toString();
      }
    }

    // Getting User Details
    Future<Map<String, dynamic>?> getUserDetails() async {
      try {
        User? user = _auth.currentUser;
        if (user == null) {
          return null;
        }

        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (!snapshot.exists) {
          return null;
        }

        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return data;
      } catch (e) {
        return null;
      }
    }

    // Signing Out User
    Future<void> signOut() async {
      await _auth.signOut();
    }
  }
}


rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write;
    }
  }
}
 */

