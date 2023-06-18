// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:marisan_pmo_project/Pages/Anggota.dart';

class tambahanggota extends StatefulWidget {
   tambahanggota({Key? key}) : super(key:key);

  @override
  State<tambahanggota> createState() => _tambahanggotaState();
}
class _tambahanggotaState extends State<tambahanggota> {
  final _addanggota = GlobalKey<FormState>();
  var nama = "";
  var nohp = "";
  var alamat = "";
   // Menyimpan Value dari Nilai Anggota
  final _NamaAnggota = TextEditingController();
  final _NoHpanggota = TextEditingController();
  final _Alamatanggota = TextEditingController();
  @override
    void dispose() {
    // Clean up the controller when the widget is disposed.
    _NamaAnggota.dispose();
    _NoHpanggota.dispose();
    _Alamatanggota.dispose();
    super.dispose();
  }
    clearText() {
    _NamaAnggota.dispose();
    _NoHpanggota.dispose();
    _Alamatanggota.dispose();
  }

  // Pilih Colection
  // CollectionReference AnggotaColection = 
  //     FirebaseFirestore.instance.collection("Tambah Anggota");

  // Future<void> _addpeople() {
  //   return AnggotaColection
  //   .add({"Nama Anggota" : _NamaAnggota.text, "Telephone Anggota": _NoHpanggota.text,"Alamat Anggota": _Alamatanggota.text})
  //   .then((value) => print("Anggota Berhasil ditambahka"))
  //   .catchError((Error) => print("Gagal Ditambahkan"));
  // }
  @override
  Widget build(BuildContext context) {
    // Menambahkan Data Pada FireStore
    // FirebaseFirestore firestore = FirebaseAuth.instance; // tambahkan cloud firestore pada pubspec  fire base auth can't be assigned to a variable of firebase firestore
    // CollectiontionReference _tambahanggota = firestore.collection("Anggota");
    return Scaffold(
      appBar: AppBar(
      title:Text("TAMBAHKAN ANGGOTA", style: TextStyle(color: Colors.white),),
      centerTitle: true,
      backgroundColor: Color.fromRGBO(20, 177, 158, 1),
      iconTheme: IconThemeData(color: Colors.white),
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
          "asset/images/tambahanggota.jpeg",
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
                  style: ElevatedButton.styleFrom(
                     primary: Color.fromRGBO(20, 177, 158, 1),
                     onPrimary: Colors.white,
                      ), 
                      onPressed: () {
                        // Button Untuk Mengoperassikan Lempar Nilai ke FireStore
                        // _tambahanggota.add ({
                        //   "Nama Anggota": _NamaAnggota.text,
                        //   "No.Hp Anggota" : int.tryParse(_NamaAnggota.text) ?? 0,
                        //   "Alamat Anggota" : _Alamatanggota.text,
                        // });
                        if (_addanggota.currentState!.validate()) {
                          setState(() {
                            _NamaAnggota.text = "";
                            _NamaAnggota.text = "";
                            _Alamatanggota.text = ""; 
                            // _addpeople(); 
                            // MaterialPageRoute(
                            //   builder: (context) => anggota()
                            // ); 
                          });
                        }
                      },
                      child: Center(child: Text("TAMBAH"))

                        // Ini Perulangan Untuk Nilai Apabila Nilai Ada Maka Akan Melanjutkan Ke Pages Anggota
/*                        if (_NamaAnggota.text.isNotEmpty && _NoHpanggota.text.isNotEmpty ) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => anggota(),
                            ),
                          );;
                     
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
                      child: Center(child: Text("TAMBAH")),
                   ),*/
                 ),
              ),
           )
        ]
      ),
      );
  }
}
