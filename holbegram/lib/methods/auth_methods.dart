import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:holbegram/screens/login_screen.dart';


class AuthMethode {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<String> login({required String email,required String password}) async {
        if (email.isEmpty || password.isEmpty) {
            return 'Please fill all the fields';
        }
        try {
            var userCredential = await _auth.signInWithEmailAndPassword(
                email: email,
                password: password,
            );
            var user = userCredential.user;
            return 'Success';
        } catch (e) {
            return e.toString();
        }
    }

    Future<String> signUpUser({
        required String email,
        required String password,
        required String username,
        Uint8List? file,
        }) async {
        if (email.isEmpty || password.isEmpty || username.isEmpty) {
            return 'Please fill all the fields';
        }
        try {
            UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                email: email,
                password: password,
            );
            User? user = userCredential.user;

            Users users = Users(
                email: email,
                username: username,
                uid: user!.uid,
                bio: '',
                photoUrl: '',
                followers: [],
                following: [],
                posts: [],
                saved: [],
                searchKey: '',
            );

            await _firestore.collection('users').doc(user.uid).set(users.toJson());
            return 'Success';
        } catch (e) {
            return e.toString();
        }
        }

        Future<Users?> getUserDetails() async {
            try {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
                final snapshot = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

                if (snapshot != null) {
                    final user = Users.fromSnap(snapshot);
                    return user;
                }
            }
        } catch (e) {
            print(e);
        }
        return null;
}

    Future<void> logOut() async {
        try {
            await _auth.signOut();
        } catch (e) {
            print("Error logging out: $e");
        }
    }
}