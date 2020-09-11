import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String dropDownValueUser;
  String buyer;
  int poin;

  String dateNow;

  TextEditingController buyItemController = TextEditingController(text: "");

  void createTransaction(String buyer, String item) {
    dateNow = DateTime.now().toString();
    DocumentReference documentReference =
        Firestore.instance.collection("Transactions").document(dateNow);

    // Mapping
    Map<String, String> transactions = {
      "tanggal": dateNow,
      "buyer": buyer,
      "namaBarang": item,
    };
    documentReference
        .setData(transactions)
        .whenComplete(() => print("berhasil menambahkan data"));
  }

  void addUserTransaction(String buyeruid, String item) {
    dateNow = DateTime.now().toString();
    DocumentReference documentReference = Firestore.instance
        .collection("Users")
        .document(buyeruid)
        .collection("Transactions")
        .document(dateNow);

    // Mapping
    Map<String, dynamic> userTransactions = {
      "tanggal": dateNow,
      "poin": 5,
      "namaBarang": item,
    };
    documentReference
        .setData(userTransactions)
        .whenComplete(() => print("berhasil menambahkan data"));
  }

  void addUserPoin(String buyer, int addPoin) {
    addPoin = addPoin + 5;
    DocumentReference documentReference =
        Firestore.instance.collection("Users").document(buyer);

    // Mapping
    Map<String, dynamic> userTransactions = {
      "poin": addPoin,
    };
    documentReference
        .updateData(userTransactions)
        .whenComplete(() => print("berhasil menambahkan data"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("Users").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshotUsers) {
            var userPoin = [];
            var userUid = [];
            DocumentSnapshot documentSnapshotUsers;
            List<DropdownMenuItem<String>> userList = [];
            for (int indexs = 0;
                indexs < snapshotUsers.data.documents.length;
                indexs++) {
              documentSnapshotUsers = snapshotUsers.data.documents[indexs];
              if (documentSnapshotUsers['admin'] == false) {
                userList.add(new DropdownMenuItem(
                    child: new Text(documentSnapshotUsers['displayName']),
                    value: documentSnapshotUsers['useruid']));
                userPoin.add(documentSnapshotUsers["poin"]);
                userUid.add(documentSnapshotUsers['useruid']);
              }
            }
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nama User'),
                    DropdownButton<String>(
                      hint: Text("Pilih Pembeli"),
                      value: dropDownValueUser,
                      onChanged: (newValue) {
                        setState(() {
                          dropDownValueUser = newValue;
                          buyer = newValue;

                          for (int i = 0; i < userUid.length; i++) {
                            if (userUid[i] == buyer) {
                              poin = userPoin[i];
                            }
                          }
                        });
                      },
                      items: userList,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text('Pembelian'),
                    TextField(
                      controller: buyItemController,
                      decoration: InputDecoration(hintText: 'Nama Barang'),
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
                        label: Text('Konfirmasi'),
                        onPressed: () {
                          createTransaction(buyer, buyItemController.text);
                          addUserPoin(buyer, poin);
                          addUserTransaction(buyer, buyItemController.text);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
