// ignore_for_file: implementation_imports
import 'dart:html';
import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:marisanif21a/pages/bayar.dart';
import 'package:marisanif21a/pages/home.dart';
import 'package:marisanif21a/pages/tambahanggota.dart';


class DaftarAnggota extends StatefulWidget {
  const DaftarAnggota({super.key});

  @override
  State<DaftarAnggota> createState() => _DaftarAnggotaState();
}

class _DaftarAnggotaState extends State<DaftarAnggota> {
  int currentIndex = 1; // init Buttom Navigatorbar
  bool isButton1Locked = false;// init button
  void onTabTapped(int index) {
  setState(() {
    currentIndex = index;  
  //  pageController.jumpToPage(index);
  });
  if (currentIndex == 0) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } else if (currentIndex == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DaftarAnggota()),
      );
  }
}
//Controll Buttton Function
 void lockButton1() {
  setState(() {
    isButton1Locked = true;
  });
}
void unlockButton1() {
  setState(() {
    isButton1Locked = false;
  });
}
//Cek Data Ke Firestore
Future<void> checkDataInFirestore() async {
  var snapshot = await FirebaseFirestore.instance
      .collection('Data Spinner')
      .get();

  if (snapshot.size == 0) {
    // Data di Firestore kosong, kunci Button1
    lockButton1();
  } else {
    // Data ada di Firestore, buka kunci Button1
    unlockButton1();
  }
}


// Get Anggota
final _userStreamanggota = 
      FirebaseFirestore.instance.collection('Tambah Anggota').snapshots();
// Show Dialog Nominal
  void _nominal(){
    AlertDialog alertDialog = AlertDialog(
      content: Container(
        height: 200.0,
        width: 300.0,
        child: Column(
          children: [
            Text("Masukkan Nominal",
            style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              decoration: InputDecoration(
                labelText: "Masukkan Nominal",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(20, 177, 158, 1),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ), child: Text("Mulai"),
                  onPressed: () {
                    Navigator.push(context,
                   MaterialPageRoute(builder: (context) => bayar()));
                  },
              )
            )
          ]
        ),
      ),
    );
// Delete Dokument All
void deleteData(String documentId) {
  FirebaseFirestore.instance
      .collection('nama_collection')
      .doc(documentId)
      .delete()
      .then((value) {
    // Data berhasil dihapus
    print('Data berhasil dihapus');
  }).catchError((error) {
    // Terjadi error saat menghapus data
    print('Error saat menghapus data: $error');
  });
}
// Show Dialog Error masih
void showDeleteDialog(String documentId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda ingin menghapus data ini?'),
        actions: [
          TextButton(
            child: Text('Hapus'),
            onPressed: () {
              deleteData(documentId);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Ubah'),
            onPressed: () {
              // Tambahkan kode untuk membuka halaman ubah data
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Batal'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

    showDialog(
    context: context,
    builder: (BuildContext context){
      return alertDialog;
    }
  );
  }

int cIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Daftar Anggota',style: TextStyle(color: Colors.white))),
        backgroundColor: Color.fromRGBO(20, 177, 158, 1),
      ),
      body: StreamBuilder(
        stream: _userStreamanggota,
        builder: (context,snapshot) {
          if (snapshot.hasError) {
            return const Text("Conenction Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text ("Loading ...............");
          }
          var docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context,index) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ///showDialogDelete)
                    }, 
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(docs[index]['Nama Anggota']),
                      subtitle:  Text('${docs[index]['Telephone Anggota']}'),
                    ),
                  )
                ],
              );

            },
          );
        }),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Padding(padding: const EdgeInsets.only(left: 30, right: 10),
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color.fromRGBO(20, 177, 158, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                  ), 
                  child: Center(child: Text("Tambah Anggota")),
                  onPressed: (){
                    lockButton1();
                    checkDataInFirestore();
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => tambahanggota()),
                    );
                  },
                  ),  
                ),
              ),
              Padding(padding: const EdgeInsets.only(left: 20, right:30),
              child: Container(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color.fromRGBO(20, 177, 158, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ), 

                child: Center(child: Text("Mulai")),
                onPressed: isButton1Locked ? null : (){
                  _nominal();
                },
              ),
            ),
          ),
          ],
      ), 
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "ANGGOTA")
              
        ]),
    );
    
  }
}
