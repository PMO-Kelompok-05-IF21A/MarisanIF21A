import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marisanif21a/pages/Selamat.dart';

class spiner extends StatefulWidget {
   spiner({Key? key});

  @override
  State<spiner> createState() => _spinerState();
}

class _spinerState extends State<spiner> {
  bool isSpinning = false;
   StreamController<int> selected = StreamController<int>();
   List<String> items = [];
   String selectedName = '';


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItemsFromFirestore();
    selected.add(Fortune.randomInt(0, items.length));
  }

@override
  void dispose() {
    // TODO: implement dispose
    selected.close(); 
    super.dispose();
  }
 Future<void> fetchItemsFromFirestore() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Data Spinner')
          .get();

      setState(() {
        items = snapshot.docs.map((doc) => doc['Nama'] as String).toList();
      });

      if (items.length >= 2) {
        selected.add(Fortune.randomInt(0, items.length));
      } else {
        throw Exception('Tidak Dapat Memutar Spinner');
      }
    } catch (error) {
      print('Error fetching items: $error');
    }
  }
  Future<void> deleteSelectedItem() async {
    try {
      int selectedIndex = await selected.stream.first;
      if (selectedIndex >= 0 && selectedIndex < items.length) {
        String selectedItem = items[selectedIndex];
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('Data Spinner')
            .where('Nama', isEqualTo: selectedItem)
            .get();

        snapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      }
    } catch (error) {
      print('Error deleting selected item: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 177, 158, 1),
        title: const Center(
          child: Text(
            "MARISAN SPINNER",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
        body:SafeArea(
          child: Center(
            child: Container(
              width: 300,
              height: 300,
              child: items.length >= 2
                  ? FortuneWheel(
                  animateFirst: false,
                      selected: selected.stream,
                      items: [
                        for (var it in items) FortuneItem(child: Text(it)),
                      ],
                    )
                  : Text('MAAF TIDAK ADA ANGGOTA YANG TERDAFTAR',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Roboto",
                        color:(Color.fromRGBO(20, 177, 158, 1)),
                          ),
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,),
            ),
          ),
          ),
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
                  child: Center(child: Text("SPIN")),
                  onPressed: (){
                      if (!isSpinning && items.length > 1) {
                      setState(() {
                        isSpinning = true;
                      });
                      Timer(Duration(seconds: 1), () {
                        setState(() {
                          int selectedIndex = Fortune.randomInt(0, items.length);
                          selected.add(selectedIndex);
                          selectedName = items[selectedIndex];
                          isSpinning = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => congrat(selectedName: selectedName),
                            ),
                          );
                          firestore.collection('Data Menang').add({
                           'selectedName': selectedName,
                             });
                        });
                      });
                     }
                    }
                  ),  
                ),
              ),

          ],
          ), 
       );
  }
}