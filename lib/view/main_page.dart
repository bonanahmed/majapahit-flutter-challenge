import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/User_Page/main_page_user.dart';
import '../view/Admin_Page/main_page_admin.dart';

class MainPage extends StatelessWidget {
  final FirebaseUser firebaseUser;
  MainPage(this.firebaseUser);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: Firestore.instance
          .collection("Users")
          .document(firebaseUser.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data;
          bool isAdmin = data['admin'];
          if (isAdmin) {
            return MainPageAdmin(data["useruid"]);
          } else {
            return MainPageUser(data["useruid"]);
          }
        }
        return Scaffold(
            body: Container(
          child: Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.orange[300],
          )),
        ));
      },
    );
  }
}
