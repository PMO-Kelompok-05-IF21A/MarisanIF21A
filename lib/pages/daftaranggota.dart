import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:marisanif21a/pages/tambahanggota.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';

class DaftarAnggota extends StatefulWidget {
  const DaftarAnggota({super.key});

  @override
  State<DaftarAnggota> createState() => _DaftarAnggotaState();
}

class _DaftarAnggotaState extends State<DaftarAnggota> {

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
                    // buat algoritma menyimpan data ke firebase
                   // Navigator.push(context,
                   // MaterialPageRoute(builder: (context) => Mulai()));
                  },
              )
            )
          ]
        ),
      ),
    );
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
      body: ListView(
        children: <Widget>[
          SizedBox(height: 100),
          Container(  
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
                ),
                filled: true,
                fillColor: Colors.grey,
                labelText: "Bernardus                         089656722809"   
              )
            ),
          ),
              SizedBox(height: 20,),
              Padding(padding: const EdgeInsets.only(left: 100, right: 100),
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color.fromRGBO(20, 177, 158, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                  ), 
                  child: Center(child: Text("Tambah Anggota")),
                  onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => tambahanggota()),
                    );
                  },
                  ),  
                ),
              ),
              SizedBox(height: 20,),
              Padding(padding: const EdgeInsets.only(left: 100, right: 100),
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color.fromRGBO(20, 177, 158, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ), 

                child: Center(child: Text("Mulai")),
                onPressed: (){
                  _nominal();
                },
              ),
            ),
          ),
        ],
      ), 
      bottomNavigationBar: SweetNavBar(
        currentIndex: cIndex,
        paddingBackgroundColor: Colors.transparent,
        items: [
          SweetNavBarItem(
              sweetActive: const Icon(Icons.home),
              sweetIcon: const Icon(
                Icons.home_outlined,
              ),
              sweetLabel: 'Home',
             // iconColors: iconLinearGradiant,
              sweetBackground: Colors.red),
          
          SweetNavBarItem(
              sweetIcon: const Icon(Icons.people_outline,), 
              sweetLabel: 'Anggota',
              sweetBackground: Colors.red),
        ],
        onTap: (index) {
          setState(() {
            cIndex = index;
          });
        },
      ),
    );
  }
}