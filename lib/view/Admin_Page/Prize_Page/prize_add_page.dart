import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'prize_list_page.dart';

class PrizeAddPage extends StatefulWidget {
  @override
  _PrizeAddPageState createState() => _PrizeAddPageState();
}

class _PrizeAddPageState extends State<PrizeAddPage> {
  TextEditingController itemNameController = TextEditingController(text: "");
  TextEditingController itemPointController = TextEditingController(text: "");

  void createItem(String itemName, int itemPoin) {
    DocumentReference documentReference =
        Firestore.instance.collection("Prizes").document(itemName);

    // Mapping
    Map<String, dynamic> items = {
      "namaBarang": itemName,
      "poinBarang": itemPoin,
    };
    documentReference
        .setData(items)
        .whenComplete(() => print("berhasil menambahkan item"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Daftar Hadiah'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Barang'),
              TextField(
                controller: itemNameController,
                decoration: InputDecoration(hintText: 'Nama Barang'),
              ),
              Spacer(
                flex: 1,
              ),
              Text('Poin Barang'),
              TextField(
                controller: itemPointController,
                decoration: InputDecoration(hintText: 'Poin Barang'),
              ),
              Spacer(
                flex: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton.icon(
                  color: Colors.orange[300],
                  icon: Icon(Icons.input),
                  label: Text('Tambah Barang'),
                  onPressed: () {
                    setState(() {
                      createItem(itemNameController.text,
                          int.parse(itemPointController.text));

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return PrizeListPage();
                      }));
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
