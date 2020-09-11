import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majapahit_flutter_challenge/view/Admin_Page/User_Management_Page/user_edit_page.dart';

class ProfilePage extends StatefulWidget {
  final String useruid;
  const ProfilePage({Key key, this.useruid}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> deleteUser(String data) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    DocumentReference documentReference =
        Firestore.instance.collection("Users").document(data);
    documentReference.delete();

    FirebaseUser user = await _firebaseAuth.currentUser();
    user.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection("Users")
            .document(widget.useruid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data;
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserEditPage(
                                          userDisplayName: data['displayName'],
                                          useruid: widget.useruid,
                                        )));
                          });
                        })
                  ],
                  title: Text('Profile'),
                ),
                body: Container(
                  padding: EdgeInsets.all(9),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("User ID"),
                        subtitle: Text(data['useruid']),
                      ),
                      ListTile(
                        title: Text("Name"),
                        subtitle: Text(data['displayName']),
                      ),
                      ListTile(
                        title: Text("Poin"),
                        subtitle: Text(data['poin'].toString()),
                      ),
                      Spacer(
                        flex: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton.icon(
                          color: Colors.orange[300],
                          icon: Icon(Icons.delete),
                          label: Text('Delete Akun'),
                          onPressed: () {
                            setState(() {
                              deleteUser(data['useruid']);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ));
          }

          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orange[300],
            ),
          ));
        });
  }
}
