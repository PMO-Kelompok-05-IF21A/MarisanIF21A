import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class recordbayar extends StatefulWidget {
  const recordbayar({super.key});

  @override
  State<recordbayar> createState() => _recordbayarState();
}

class _recordbayarState extends State<recordbayar> {

void deleteAllData() {
  FirebaseFirestore.instance
      .collection('Transaksi')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((DocumentSnapshot doc) {
      doc.reference.delete();
    });
    // Seluruh data berhasil dihapus
    print('Seluruh data berhasil dihapus');
  }).catchError((error) {
    // Terjadi error saat menghapus data
    print('Error saat menghapus data: $error');
  });
}
  @override
 Widget build(BuildContext context) {
  FirebaseFirestore.instance.collection('Transaksi').snapshots();
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(20, 177, 158, 1),
      title: Center(
        child: Text('RECORD PEMBAYARAN', style: TextStyle(color: Colors.white))),
    ),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('Transaksi')
        .orderBy('Tanggal Bayar', descending: true)
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Connection Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading ...............");
        }

        var docs = snapshot.data!.docs;
        return Container(
          height: MediaQuery.of(context).size.height, // Set a fixed height
          child: ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(docs[index]['Nama Anggota']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text('${docs[index]['Nominal Arisan']}'),
                      Text('${docs[index]['Tanggal Bayar']}'),
                  ],
                ),
              );
            },
          ),
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
              child: Center(child: Text("HAPUS RECORD")),
              onPressed: (){
                deleteAllData();
              },
            ),
          ),
        ),
      ],
    ),
  );
 }
}