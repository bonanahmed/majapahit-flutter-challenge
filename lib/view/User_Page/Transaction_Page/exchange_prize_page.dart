import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExchangePrizePage extends StatefulWidget {
  final String useruid;
  const ExchangePrizePage({Key key, this.useruid}) : super(key: key);
  @override
  _ExchangePrizePageState createState() => _ExchangePrizePageState();
}

class _ExchangePrizePageState extends State<ExchangePrizePage> {
  int userPoin;
  String status;
  void updatePoin(String id, int poinUser, int poinItem) {
    DocumentReference documentReference =
        Firestore.instance.collection("Users").document(id);
    int poinAdd;
    if (poinUser >= poinItem) {
      poinAdd = poinUser - poinItem;
      status = 'Berhasil Menukarkan Hadiah';
    } else {
      status = 'Poin Tidak Mencukupi';
    }
    // Mapping
    Map<String, dynamic> addPoin = {
      "poin": poinAdd,
    };
    if (poinUser >= poinItem) {
      documentReference
          .updateData(addPoin)
          .whenComplete(() => print("berhasil menambahkan data"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tukar Hadiah'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                child: FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection("Users")
                  .document(widget.useruid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data;
                  userPoin = data['poin'];
                  return Column(
                    children: [
                      ListTile(
                        title: Text("${data['displayName']}"),
                        subtitle: Text("Poin: ${data['poin']}"),
                      ),
                      Center(
                        child:
                            SizedBox(height: 50, child: Text("DAFTAR HADIAH")),
                      )
                    ],
                  );
                }

                return Text("loading");
              },
            )),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("Prizes").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                  subtitle: Text(
                                      "Poin: ${documentSnapshot["poinBarang"].toString()}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.compare_arrows),
                                    onPressed: () {
                                      setState(() {
                                        int itemPoin =
                                            documentSnapshot['poinBarang'];
                                        updatePoin(
                                            widget.useruid, userPoin, itemPoin);
                                      });
                                      return Fluttertoast.showToast(
                                          msg: status);
                                    },
                                  ),
                                ),
                              );
                            });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
