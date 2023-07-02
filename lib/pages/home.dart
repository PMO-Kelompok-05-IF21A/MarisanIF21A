import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marisanif21a/pages/bayar.dart';
import 'package:marisanif21a/pages/daftaranggota.dart';
import 'package:marisanif21a/pages/spinner.dart';


class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userStream = 
      FirebaseFirestore.instance.collection('Transaksi').snapshots();
  
void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
int currentIndex =0;
//PageController pageController;
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
/*@override
  void initState() {
    pageController =PageController(initialPage: currentIndex);
    super.initState();
  }
@override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        backgroundColor: Color.fromRGBO(20, 177, 158, 1),
        title :Text("Homepage"
        ),
        actions :[
          IconButton(
            onPressed: signUserOut, // Lakukan Pembuata Function Untuk Log Out
            icon: Icon(Icons.logout)
            )
        ]
      ),
      body: StreamBuilder(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Conection Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading ..........");
          }
          var docs = snapshot.data!.docs;
         // return Text('${docs.length}');
         return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => bayar()),
                  );
               },
                child:
                ListTile(

                  leading: const Icon(Icons.person),
                  title: Text(docs[index]['Nama Anggota']),
                  subtitle: Text('${docs[index]['Nominal Arisan']}'),
                ),
            )
            ],
            );
          },
         );
        }
      ),
       floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 100)),
          ElevatedButton(
            onPressed: () {
              deleteAllData();
               Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => spiner())
                  );
            },
             child: Text(
              "KOCOK",
              )
              )
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
         ],
        ),
        /*  PageView(
            controller: pageController,
            onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: [
            HomePage(),
            anggota(),
             ],
            ),
        */
            );
          }
        }
