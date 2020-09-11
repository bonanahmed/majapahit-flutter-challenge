import 'package:flutter/material.dart';
import 'package:majapahit_flutter_challenge/view/signup_page.dart';

import '../auth_services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Variable Declaration
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 5,
            ),
            Text(
              'Silahkan Login',
              style: TextStyle(fontSize: 30),
            ),
            Spacer(flex: 2),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            Spacer(
              flex: 1,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            Spacer(
              flex: 1,
            ),
            RaisedButton(
              color: Colors.orange[300],
              child: Text(
                'Login',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await AuthServices.signIn(
                    emailController.text, passwordController.text);
              },
            ),
            FlatButton(
              // color: Colors.orange[300],
              child: Text(
                'Belum Punya Akun? Daftar Disini',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                });
              },
            ),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
