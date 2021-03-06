import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Transaksi')),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Transactions").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return (!snapshot.hasData)
              ? Center(child: Text("No Data Found"))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.documents[index];

                    return Card(
                      child: ListTile(
                        title: Text(documentSnapshot["tanggal"]),
                        subtitle:
                            Text("Barang: ${documentSnapshot["namaBarang"]}"),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.delete),
                        //   onPressed: () {
                        //     setState(() {});
                        //   },
                        // ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
