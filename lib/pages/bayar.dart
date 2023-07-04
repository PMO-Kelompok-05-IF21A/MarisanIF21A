import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/home.dart';

String Nama = "";

class bayar extends StatelessWidget {
   bayar({super.key});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController Namabayar = TextEditingController();
  final TextEditingController hargabayar = TextEditingController();
  void createbayar() async {
    String _namabayar = Namabayar.text;
    String _hargabayar = hargabayar.text;
    await firestore.collection('Bayar').doc().set({
      "Nama Anggota": _namabayar,
      "Nominal Arisan": _hargabayar,
    });
  }
  void creattransaksi() async {
    String _namabayar = Namabayar.text;
    String _hargabayar = hargabayar.text;
    await firestore.collection('Transaksi').doc().set({
      "Nama Anggota": _namabayar,
      "Nominal Arisan": _hargabayar,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 177, 158, 1),
        centerTitle: true,
        title : Text(Nama) // Disini Memanggil Nilai Dari Inputan Variabel dan pada Halaman Sebelmunya  Route  MaterialPageRoute(builder:(context) => signUp( nama : Controll.text dari TextEditing Controller)),
      ),
      body: ListView(
        children: <Widget>[
          Container(
          child: Image.asset(
         "asset/images/bayar.png",
          height: 283,
          width: 255,
          alignment: Alignment.center,
          ),
       ),
       SizedBox(height:5.0),
          Padding(
            padding: const EdgeInsets.only(left:16.0, top: 10.0, right: 16),
            child: SizedBox(
              height: 56,
              width: 315,
              child: TextField(
                controller: Namabayar,
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
                controller: hargabayar,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nominal Arisan',
                  prefixIcon: Icon(Icons.monetization_on)
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
                  style: ElevatedButton.styleFrom(
                     primary: Color.fromRGBO(20, 177, 158, 1),
                     onPrimary: Colors.white,
                      ),
                      child: Center(child: Text("BAYAR")),
                      onPressed: () {
                       createbayar();
                       creattransaksi();
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), 
                      // Disini Lakukan Algoritma Untuk Memasukan Nilai
                      ); 
                    }  
                   ),
                 ),
              ),
          SizedBox(height: 10,),
          Padding(
              padding: const EdgeInsets.only(left:16.0,right:16),
              child: Container(
                  width: 172,
                  height: 39 ,
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                     primary: Color.fromRGBO(20, 177, 158, 1),
                     onPrimary: Colors.white,
                      ),
                      child: Center(child: Text("LEWATI")),
                      onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      // Disini Lakukan Algoritma Untuk Memasukan Nilai
                      ); 
                    }  
                   ),
                 ),
              ),
        ]
      )
    );
  }
}