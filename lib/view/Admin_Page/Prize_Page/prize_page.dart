import 'package:flutter/material.dart';

import 'prize_add_page.dart';
import 'prize_list_page.dart';

class PrizePage extends StatefulWidget {
  @override
  _PrizePageState createState() => _PrizePageState();
}

class _PrizePageState extends State<PrizePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Hadiah'),
      ),
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
                    icon: Icon(Icons.list),
                    label: Text('Daftar Hadiah'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PrizeListPage();
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
                    icon: Icon(Icons.playlist_add),
                    label: Text('Tambah Hadiah'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PrizeAddPage();
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
