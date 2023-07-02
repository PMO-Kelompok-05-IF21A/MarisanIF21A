// Data Tambah Anggota Sudah Masuk Pada Database


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/daftaranggota.dart';



class tambahanggota extends StatefulWidget {
   tambahanggota({super.key});

  @override
  State<tambahanggota> createState() => _tambahanggotaState();
}
class _tambahanggotaState extends State<tambahanggota> {
   // Menyimpan Value dari Nilai Anggota
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _NamaAnggota = TextEditingController();
  final _NoHpanggota = TextEditingController();
  final _Alamatanggota = TextEditingController();
  void createAnggota() async {
    String namaAnggota = _NamaAnggota.text;
    String noHpAnggota = _NoHpanggota.text;
    String alamatAnggota = _Alamatanggota.text;
    await firestore.collection('Tambah Anggota').doc().set({
      "Alamat Anggota": alamatAnggota,
      "Nama Anggota": namaAnggota,
      "Telephone Anggota": noHpAnggota,
    });
  }
  void creatspindata() async {
    String _namabayar = _NamaAnggota.text;
    await firestore.collection('Data Spinner').doc().set({
    "Nama": _namabayar,
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menambahkan Data Pada FireStore
    // FirebaseFirestore firestore = FirebaseAuth.instance; // tambahkan cloud firestore pada pubspec  fire base auth can't be assigned to a variable of firebase firestore
     // CollectiontionReference _tambahanggota = firestore.collection("Anggota");
    return Scaffold(
      appBar: AppBar(
      title:Text("TAMBAHKAN ANGGOTA"),
      centerTitle: true,
      backgroundColor: Color.fromRGBO(20, 177, 158, 1),
      iconTheme: IconThemeData(color: Colors.black),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
          },
        )
      ), 
      body: ListView(
        children: <Widget>[
          SizedBox(height: 50),
          Container(
          child: Image.asset(
          "assets/images/tambahanggota.png",
          height: 200,
          width: 200,
          alignment: Alignment.center,
          ),
       ),
       SizedBox(height:20.0),
          Padding(
            padding: const EdgeInsets.only(left:16.0, top: 10.0, right: 16),
            child: SizedBox(
              height: 56,
              width: 315,
              child: TextField(
                controller: _NamaAnggota,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Anggota',
                  prefixIcon: Icon(Icons.person)
                ),
              ),
            ),
          ),
          SizedBox(height:5.0),
          Padding(
            padding: const EdgeInsets.only(left:16.0, top: 10.0, right: 16),
            child: SizedBox(
              height: 56,
              width: 315,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nomor Telepon',
                  prefixIcon: Icon(Icons.phone_android_outlined),
                ),
                controller: _NoHpanggota,
              ),
            ),
          ),
          SizedBox(height:5.0),
          Padding(
            padding: const EdgeInsets.only(left:16.0, top: 10.0, right: 16),
            child: SizedBox(
              height: 56,
              width: 315,
              child: TextField(
                controller: _Alamatanggota,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Alamat Anggota',
                  prefixIcon: Icon(Icons.location_on_rounded)
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
           Padding(
              padding: const EdgeInsets.only(left:16.0,right:16),
              child: Container(
                  width: 172,
                  height: 39 ,
                  child: ElevatedButton(
                  child: Text("TAMBAH"),
                  style: ElevatedButton.styleFrom(
                     primary: Color.fromRGBO(20, 177, 158, 1),
                     onPrimary: Colors.white,
                      ), 
                      onPressed: () {
                        if (_NamaAnggota.text.isNotEmpty && _NoHpanggota.text.isNotEmpty ) {
                          setState(() {
                            createAnggota();
                            creatspindata();
                             Navigator.push(context,
                              MaterialPageRoute(builder: (context) => DaftarAnggota()),
                              );
 
                          });
                       } else {
                          // Tampilkan pesan bahwa TextField belum terisi
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Isi Dulu Kolom Sebelum melanjutkan',
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.red
                                ),),
                            ),
                          );
                        }
                      },
                   ),
                 ),
              ),
        ]
      ),
      );
  }
}
