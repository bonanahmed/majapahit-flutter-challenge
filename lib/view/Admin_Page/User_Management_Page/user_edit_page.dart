import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:majapahit_flutter_challenge/view/User_Page/Profile_Page/profile_page.dart';

class UserEditPage extends StatefulWidget {
  final String userDisplayName;
  final String useruid;
  const UserEditPage({Key key, this.userDisplayName, this.useruid})
      : super(key: key);
  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  TextEditingController displayNameController = TextEditingController(text: "");

  void updateUser(String displayName) {
    DocumentReference documentReference =
        Firestore.instance.collection("Users").document(widget.useruid);

    // Mapping
    Map<String, dynamic> users = {
      "displayName": displayName.toString(),
    };
    documentReference
        .updateData(users)
        .whenComplete(() => print("berhasil menambahkan data"));
  }

  @override
  Widget build(BuildContext context) {
    displayNameController.text = widget.userDisplayName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Admin'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name'),
              TextField(
                controller: displayNameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              Spacer(
                flex: 1,
              ),
              Spacer(
                flex: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton.icon(
                  color: Colors.orange[300],
                  icon: Icon(Icons.edit),
                  label: Text('Edit Data'),
                  onPressed: () {
                    updateUser(displayNameController.text);
                    setState(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return ProfilePage(
                          useruid: widget.useruid,
                        );
                      }));
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
