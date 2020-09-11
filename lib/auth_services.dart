import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String errorMessage;

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Future<FirebaseUser> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return firebaseUser;
    } catch (e) {
      errorMessage = (e.toString());
      return null;
    }
  }

  static Future<FirebaseUser> signUp(
      String email, String password, String displayName, bool isAdmin) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      DocumentReference documentReference =
          Firestore.instance.collection("Users").document(firebaseUser.uid);

      // Mapping
      Map<String, dynamic> users = {
        "useruid": firebaseUser.uid.toString(),
        "displayName": displayName.toString(),
        "admin": isAdmin,
        "poin": 0,
      };
      documentReference
          .setData(users)
          .whenComplete(() => print("berhasil menambahkan data"));

      return firebaseUser;
    } catch (e) {
      errorMessage = (e.toString());
      return null;
    }
  }

  static Stream<FirebaseUser> get fireBaseUserStream =>
      _auth.onAuthStateChanged;
}
