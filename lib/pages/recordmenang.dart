import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//memperbaiki3
class recordmenang extends StatefulWidget {
  const recordmenang({Key? key});
  @override
  State<recordmenang> createState() => _recordmenangState();
}
class _recordmenangState extends State<recordmenang> {
  Future<void> deleteAllData() async {
    await FirebaseFirestore.instance.collection('Data Menang').get().then(
      (snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      },
    );
  }
  Future<void> deleteAllDataSpinner() async {
    await FirebaseFirestore.instance.collection('Data Spinner').get().then(
      (snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      },
    );
  }
  Future<void> deleteNominalArisan() async {
    await FirebaseFirestore.instance.collection('Nominal Arisan').get().then(
      (snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 177, 158, 1),
        title: const Center(
          child: Text(
            "RECORD PEMENANG",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Data Menang').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Connection Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading ...............");
          }
          var docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // No button operation
                    },
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(docs[index]['selectedName']),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 10),
            child: Container(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(20, 177, 158, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Center(child: Text("HAPUS SEMUA RECORD")),
                onPressed:() {
                setState(() {
                  deleteAllDataSpinner();
                  deleteAllData();
                  deleteNominalArisan();
                });
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}