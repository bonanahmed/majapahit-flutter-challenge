import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth_services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController displayNameController = TextEditingController(text: "");

  static Future createUser(
      String email, String password, String displayName, bool isAdmin) async {
    AuthServices.signUp(email, password, displayName, isAdmin);
  }

  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    // loadAdminAnswer();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Akun'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email'),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              Spacer(
                flex: 1,
              ),
              Text('Password'),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              Spacer(
                flex: 1,
              ),
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
                  icon: Icon(Icons.input),
                  label: Text('Buat Akun'),
                  onPressed: () {
                    createUser(emailController.text, passwordController.text,
                        displayNameController.text, isAdmin);
                    setState(() {
                      Navigator.pop(context);
                    });
                    return Fluttertoast.showToast(msg: "Akun Berhasil Dibuat");
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
