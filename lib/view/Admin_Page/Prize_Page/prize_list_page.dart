import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PrizeListPage extends StatefulWidget {
  @override
  _PrizeListPageState createState() => _PrizeListPageState();
}

class _PrizeListPageState extends State<PrizeListPage> {
  void deleteItems(String data) {
    DocumentReference documentReference =
        Firestore.instance.collection("Prizes").document(data);

    documentReference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Hadiah'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("Prizes").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return !snapshot.hasData
                ? Center(child: Text("No Data Found"))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.documents[index];
                      return Card(
                        child: ListTile(
                          title: Text(documentSnapshot["namaBarang"]),
                          subtitle:
                              Text(documentSnapshot["poinBarang"].toString()),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                deleteItems(documentSnapshot["namaBarang"]);
                                print(
                                    "berhasil menghapus data ${documentSnapshot["namaBarang"]}");
                              });
                            },
                          ),
                        ),
                      );
                    });
          }),
    );
  }
}
