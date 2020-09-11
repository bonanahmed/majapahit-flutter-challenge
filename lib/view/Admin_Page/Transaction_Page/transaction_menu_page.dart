import 'package:flutter/material.dart';
import 'transaction_history_page.dart';

import 'transaction_page.dart';

class TransactionMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Transaksi"),
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
                    icon: Icon(Icons.input),
                    label: Text('Transaksi'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TransactionPage();
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
                    icon: Icon(Icons.history),
                    label: Text('Riwayat Transaksi'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TransactionHistoryPage();
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
