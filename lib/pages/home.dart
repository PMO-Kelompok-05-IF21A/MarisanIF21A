import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marisanif21a/pages/Login.dart';
import 'package:marisanif21a/pages/daftaranggota.dart';
import 'package:marisanif21a/pages/recordmenang.dart';
import 'package:marisanif21a/pages/spinner.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userStream = FirebaseFirestore.instance.collection('Bayar').snapshots();
  final _daftarAnggotaStream = FirebaseFirestore.instance.collection('Tambah Anggota').snapshots();

  double getBalance(List<dynamic> docs) {
    double total = 0;
    for (var doc in docs) {
      var nominalArisan = doc['Nominal Arisan'];
      if (nominalArisan is String) {
        total += double.parse(nominalArisan);
      } else if (nominalArisan is int || nominalArisan is double) {
        total += nominalArisan.toDouble();
      } else {
        // Handle unsupported type or null value
        // You can choose to throw an error, skip the value, or handle it differently based on your requirements.
      }
    }
    return total;
  }
  
  void signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      print('Sign Out Berhasil');
      // Navigasi ke halaman login atau halaman lain yang sesuai setelah signout
    } catch (e) {
      print('Gagal Sign Out: $e');
    }
  }

  int currentIndex = 0;
  bool canKocok = true;

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

  void deleteAllData() {
    FirebaseFirestore.instance.collection('Bayar').get().then((QuerySnapshot querySnapshot) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 177, 158, 1),
        title: Center(
          child: Text(
            "HOMEPAGE",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Connection Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading ..........");
          }
          var docs = snapshot.data!.docs;

          return StreamBuilder(
            stream: _daftarAnggotaStream,
            builder: (context, daftarAnggotaSnapshot) {
              if (daftarAnggotaSnapshot.hasError) {
                return const Text("Connection Error");
              }
              if (daftarAnggotaSnapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading ..........");
              }
              var daftarAnggotaDocs = daftarAnggotaSnapshot.data!.docs;

              // Check if the lengths of both snapshots are the same
              if (docs.length == daftarAnggotaDocs.length) {
                canKocok = true;
              } else {
                canKocok = false;
              }

              return Column(
                children: [
                  Text(
                    'Total Saldo: ${getBalance(docs)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(
                                  docs[index]['Nama Anggota'].toUpperCase(),
                                  style: TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  '${docs[index]['Nominal Arisan']}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
            padding: EdgeInsets.only(bottom: 20),
          ),
          ElevatedButton(
            onPressed: canKocok
                ? () {
                    deleteAllData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => spiner()),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              primary: canKocok ? Colors.teal : Colors.grey,
              onPrimary: Colors.white,
            ),
            child: Text(
              "KOCOK",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => recordmenang())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                  ),
                  child: const Text(
                    "RECORD PEMENANG",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
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
}
