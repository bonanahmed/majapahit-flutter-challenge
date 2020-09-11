import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  // void deleteUser(String data) {
  //   DocumentReference documentReference =
  //       Firestore.instance.collection("Users").document(data);

  //   documentReference.delete();
  // }

  void confirmAdmin(String useruid) {
    DocumentReference documentReference =
        Firestore.instance.collection("Users").document(useruid);

    // Mapping
    Map<String, dynamic> users = {
      "admin": true,
    };
    documentReference
        .updateData(users)
        .whenComplete(() => print("berhasil menambahkan data"));
  }

  void cancelAdmin(useruid) {
    DocumentReference documentReference =
        Firestore.instance.collection("Users").document(useruid);

    // Mapping
    Map<String, dynamic> users = {
      "admin": false,
    };
    documentReference
        .updateData(users)
        .whenComplete(() => print("berhasil menambahkan data"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daftar User & Admin'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("Users").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return (!snapshot.hasData)
                ? Center(child: Text("No Data Found"))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      String levelAdmin;
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.documents[index];
                      if (documentSnapshot["admin"] == true) {
                        levelAdmin = 'Admin';
                        return Card(
                          child: ListTile(
                            title: Text(documentSnapshot["displayName"]),
                            subtitle: Text(levelAdmin),
                            trailing: IconButton(
                              color: Colors.green[300],
                              icon: Icon(Icons.check),
                              onPressed: () {
                                setState(() {
                                  cancelAdmin(documentSnapshot["useruid"]);
                                });
                                return Fluttertoast.showToast(
                                    msg: "Status Admin Dibatalkan");
                              },
                            ),
                          ),
                        );
                      } else {
                        levelAdmin = "User";
                        return Card(
                          child: ListTile(
                            title: Text(documentSnapshot["displayName"]),
                            subtitle: Text(levelAdmin),
                            trailing: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                setState(() {
                                  confirmAdmin(documentSnapshot["useruid"]);
                                });
                                return Fluttertoast.showToast(
                                    msg: "Admin Terkonfirmasi");
                              },
                            ),
                          ),
                        );
                      }
                    });
          },
        ));
  }
}
