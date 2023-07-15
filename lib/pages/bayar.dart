import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/home.dart';

class Bayar extends StatefulWidget {
  final String namaAnggota;

  Bayar({required this.namaAnggota});

  @override
  _BayarState createState() => _BayarState();
}

class _BayarState extends State<Bayar> {
  final TextEditingController namabayarController = TextEditingController();
  final TextEditingController hargabayarController = TextEditingController();
  final TextEditingController tglbayarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    namabayarController.text = widget.namaAnggota;
    getNominalArisan();
  }

  void createbayar(BuildContext context, double selisih) async {
    String _namabayar = namabayarController.text;
    double _hargabayar = double.parse(hargabayarController.text);
    String _tglbayar = tglbayarController.text;
    String status = selisih < 0 ? "Rp -${-selisih}" : "Lunas";

    await FirebaseFirestore.instance.collection('Transaksi').doc().set({
      "Nama Anggota": _namabayar,
      "Nominal Arisan": _hargabayar,
      "Tanggal Bayar": _tglbayar,
      "Status": status,
    });
  }

  void creattransaksi() async {
    String _namabayar = namabayarController.text;
    String _hargabayar = hargabayarController.text;

    await FirebaseFirestore.instance.collection('Bayar').doc().set({
      "Nama Anggota": _namabayar,
      "Nominal Arisan": _hargabayar,
    });
  }

  void getNominalArisan() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Nominal Arisan')
        .orderBy('Nominal Arisan', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var nominalArisan = snapshot.docs.first['Nominal Arisan'];
      hargabayarController.text = nominalArisan;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 177, 158, 1),
        centerTitle: true,
        title: Text(
          widget.namaAnggota.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Image.asset(
              "assets/images/bayar.png",
              height: 283,
              width: 255,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16),
            child: SizedBox(
              height: 56,
              width: 315,
              child: TextField(
                controller: namabayarController,
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Anggota',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16),
            child: SizedBox(
              height: 56,
              width: 315,
              child: TextField(
                controller: hargabayarController,
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nominal Arisan',
                  prefixIcon: Icon(Icons.monetization_on),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16),
            child: SizedBox(
              height: 56,
              width: 315,
              child: TextField(
                controller: tglbayarController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tanggal Bayar',
                  prefixIcon: Icon(Icons.monetization_on),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Container(
              width: 172,
              height: 39,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(20, 177, 158, 1),
                  onPrimary: Colors.white,
                ),
                child: Center(child: Text("BAYAR")),
                onPressed: () {
                  double _hargabayar = double.parse(hargabayarController.text);
                  double selisih = -_hargabayar;
                  createbayar(context, selisih);
                  creattransaksi();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Container(
              width: 172,
              height: 39,
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
