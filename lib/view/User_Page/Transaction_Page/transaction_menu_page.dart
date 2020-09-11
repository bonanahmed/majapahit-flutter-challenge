import 'package:flutter/material.dart';
import '../Transaction_Page/exchange_prize_page.dart';
import '../Transaction_Page/transaction_history_page.dart';

class TransactionMenuPage extends StatelessWidget {
  final String useruid;
  TransactionMenuPage(this.useruid);
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
                    label: Text('Tukar Hadiah'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ExchangePrizePage(
                          useruid: useruid,
                        );
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
                        return TransactionHistoryPage(
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
