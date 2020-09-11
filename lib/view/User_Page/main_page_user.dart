import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:majapahit_flutter_challenge/view/User_Page/Profile_Page/profile_page.dart';
import '../../auth_services.dart';
import 'Transaction_Page/transaction_menu_page.dart';

class MainPageUser extends StatelessWidget {
  final String useruid;
  MainPageUser(this.useruid);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orange[300]),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu Utama'),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(child: Text('Menu')),
                decoration: BoxDecoration(
                  color: Colors.orange[300],
                ),
              ),
              ListTile(
                title: Container(
                    child: Row(
                  children: [
                    Icon(Icons.local_atm),
                    Text('Transaksi'),
                  ],
                )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TransactionMenuPage(useruid);
                  }));
                },
              ),
              ListTile(
                title: Container(
                    child: Row(
                  children: [
                    Icon(Icons.people_outline),
                    Text('Manage Akun'),
                  ],
                )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfilePage(
                      useruid: useruid,
                    );
                  }));
                },
              ),
              ListTile(
                title: Container(
                    child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    Text('Keluar'),
                  ],
                )),
                onTap: () async {
                  // Update the state of the app
                  await AuthServices.signOut();
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future:
                Firestore.instance.collection("Users").document(useruid).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data;

                return Container(
                    child: Column(
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        child: Container(
                            width: 1000,
                            height: 1000,
                            padding: EdgeInsets.all(20),
                            child: Image.asset(
                                'assets/images/majapahitid-logo.png')
                            // child: Center(child: Text('MAJAPAHIT')),
                            )),
                    Flexible(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 30, 5, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  // 'Selamat Datang ' + user.uid,
                                  'Selamat Datang ${data['displayName']}',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 65,
                                    height: 130,
                                    child: Column(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.local_atm),
                                          iconSize: 50,
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return TransactionMenuPage(
                                                  useruid);
                                            }));
                                          },
                                        ),
                                        Text(
                                          'Transaksi',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 130,
                                    child: Column(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.people_outline),
                                          iconSize: 50,
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ProfilePage(
                                                useruid: useruid,
                                              );
                                            }));
                                          },
                                        ),
                                        Text(
                                          'Manage Akun',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ));
              }
              return Container(
                  child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.orange[300],
                ),
              ));
            }),
      ),
    );
  }
}
