import 'package:flutter/material.dart';
import 'package:majapahit_flutter_challenge/view/Admin_Page/User_Management_Page/profile_page.dart';

import 'user_list_page.dart';

class UserManagementPage extends StatelessWidget {
  final String useruid;
  UserManagementPage(this.useruid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage User')),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: RaisedButton.icon(
                    color: Colors.orange[300],
                    icon: Icon(Icons.people),
                    label: Text('Daftar User & Admin'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return UserListPage();
                      }));
                    },
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: FlatButton.icon(
                    color: Colors.orange[300],
                    icon: Icon(Icons.person),
                    label: Text('Profile'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProfilePage(
                          useruid: useruid,
                        );
                      }));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
