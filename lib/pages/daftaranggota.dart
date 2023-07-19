import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/bayar.dart';
import 'package:marisanif21a/pages/home.dart';
import 'package:marisanif21a/pages/recordbayar.dart';
import 'package:marisanif21a/pages/tambahanggota.dart';
// ini Harusnya perbaikan
class DaftarAnggota extends StatefulWidget {
  const DaftarAnggota({Key? key}) : super(key: key);

  @override
  State<DaftarAnggota> createState() => _DaftarAnggotaState();
}

class _DaftarAnggotaState extends State<DaftarAnggota> {
  final Nominal = TextEditingController();
  int currentIndex = 1; // init Buttom Navigatorbar
  List<String> daftarAnggota = []; // Daftar nama anggota
  String nominalValue = "";

  @override
  void initState() {
    super.initState();
    getDaftarAnggota();
  }

  void getDaftarAnggota() async {
    // Ambil daftar nama anggota dari Firestore
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Tambah Anggota').get();
    List<String> anggota = [];
    snapshot.docs.forEach((doc) {
      anggota.add(doc['Nama Anggota']);
    });
    setState(() {
      daftarAnggota = anggota;
    });
  }

  @override
  void dispose() {
    Nominal.dispose();
    super.dispose();
  }

  void _nominal() {
    AlertDialog alertDialog = AlertDialog(
      content: Container(
        height: 200.0,
        width: 300.0,
        child: Column(
          children: [
            Text(
              "Masukkan Nominal",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextFormField(
              controller: Nominal,
              decoration: InputDecoration(
                labelText: "Masukkan Nominal",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) return " Nominal Harus Diisi";
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(20, 177, 158, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Mulai"),
                onPressed: () {
                  setState(() {
                    nominalValue = Nominal.text;
                  });
                  createNominalArisan().then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DaftarAnggota()
                        ),

                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Daftar Anggota',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromRGBO(20, 177, 158, 1),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => recordbayar()),
              );
            },
            icon: Icon(Icons.print),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Tambah Anggota')
            .snapshots(),
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
              var namaAnggota = docs[index]['Nama Anggota'];

              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (daftarAnggota.contains(namaAnggota)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bayar(
                              namaAnggota: namaAnggota,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Nama anggota tidak valid"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(namaAnggota),
                      subtitle: Text('${docs[index]['Telephone Anggota']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('Tambah Anggota')
                                  .doc(docs[index].id)
                                  .delete();
                            },
                          ),
                        ],
                      ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(child: Text("Tambah Anggota")),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => tambahanggota(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 30),
            child: Container(
              height: 40,
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(20, 177, 158, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(child: Text("Mulai")),
                onPressed: () {
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
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "ANGGOTA",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
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

  Future<void> createNominalArisan() {
    return FirebaseFirestore.instance.collection('Nominal Arisan').doc().set({
      "Nominal Arisan": nominalValue,
    });
  }
}
