import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'wrapper.dart';
import 'auth_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.fireBaseUserStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.orange[300]),
        home: Wrapper(),
      ),
    );
  }
}
