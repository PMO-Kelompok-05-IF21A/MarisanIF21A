import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:marisanif21a/pages/authPage.dart';
import 'Login.dart';

//variabel RadioListTile

//String JeniskelaminPilih = "";

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool _obscureText = true;
  // Wadah Untuk menampung value dari Text Field
  //String JeniskelaminPilih = "";
  final TextEditingController UsernameSignUpController =
      TextEditingController();
  final TextEditingController NamaSignUpController = TextEditingController();
  final TextEditingController SandiSignUpController = TextEditingController();
  final TextEditingController EmailSignUpController = TextEditingController();
  final TextEditingController NoHPSignUpController = TextEditingController();
  final TextEditingController JenisKelaminController = TextEditingController();

  @override
  void dispose() {
    UsernameSignUpController.dispose();
    NamaSignUpController.dispose();
    SandiSignUpController.dispose();
    EmailSignUpController.dispose();
    NoHPSignUpController.dispose();
    JenisKelaminController.dispose();
    super.dispose();
  }

  Future signUp() async {
    // Autentifikasi
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailSignUpController.text.trim(),
        password: SandiSignUpController.text.trim());
    // Tambah User Detail
    addUserDetails(
        UsernameSignUpController.text.trim(),
        NamaSignUpController.text.trim(),
        EmailSignUpController.text.trim(),
        SandiSignUpController.text.trim(),
        JenisKelaminController.text.trim(),
        NoHPSignUpController.text.trim());
  }

  Future addUserDetails(
      String UsernameSignUp,
      String NamaSignUp,
      dynamic SandiSignUp,
      String EmailSignUp,
      String NoHPSignUp,
      String JenisKelamin) async {
    await FirebaseFirestore.instance.collection("SIGNUP").add({
      "Username": UsernameSignUp,
      "Nama": NamaSignUp,
      "Sandi": SandiSignUp,
      "Email": EmailSignUp,
      "Telephone": NoHPSignUp,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }),
        ),
        body: ListView(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                " Daftarkan Diri!!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                  color: Color(0xff14B19E),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: 5.0),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 15, right: 16),
                    child: SizedBox(
                      height: 56,
                      width: 315,
                      child: TextField(
                          controller: UsernameSignUpController,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person), // Memasuka Icon Logo user
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color(0xff14B19E),
                              )),
                              labelText: 'Username')),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 15, right: 16),
                    child: SizedBox(
                      height: 56,
                      width: 315,
                      child: TextField(
                          controller: NamaSignUpController,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person), // Memasuka Icon Logo user
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color(0xff14B19E),
                              )),
                              labelText: 'Nama')),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 15, right: 16),
                    child: SizedBox(
                      height: 56,
                      width: 315,
                      child: TextField(
                          controller: SandiSignUpController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.key), // Memasuka Icon Logo user
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xff14B19E),
                            )),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility: Icons.visibility_off,
                                color: Color.fromARGB(255, 17, 18, 18),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 15, right: 16),
                    child: SizedBox(
                      height: 56,
                      width: 315,
                      child: TextField(
                          controller: EmailSignUpController,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.email), // Memasuka Icon Logo user
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color(0xff14B19E),
                              )),
                              labelText: 'Email')),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 15, right: 16),
                    child: SizedBox(
                      height: 56,
                      width: 315,
                      child: TextField(
                          controller: NoHPSignUpController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.phone_android), // Memasuka Icon Logo user
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color(0xff14B19E),
                              )),
                              labelText: 'Nomor Telephone')),
                    ),
                  ),
                  //                     SizedBox(height:5.0),
                  //  Padding(
                  //  padding: const EdgeInsets.only(left:16.0,top: 15, right:16),
                  //  child: SizedBox(
                  //   height:56,
                  //    width: 315,
                  //    child: TextField(
                  //     controller: JenisKelaminController,
                  //       decoration: InputDecoration(
                  //          prefixIcon: Icon(Icons.person), // Memasuka Icon Logo user
                  //          border: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Color.fromRGBO(20, 177, 158, 1)
                  //                )
                  //             ),
                  //       labelText: 'Jenis Kelamin'
                  //            )
                  //        ),
                  //     ),
                  //  ),
                  /*     Padding(
                       padding: const EdgeInsets.only(left:16, right : 15),
                       child: Text(
                        "Gender",
                        style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        color:(Color.fromRGBO(20, 177, 158, 1)),
                          ),
                        ),
                     ),
                    Row( 
                        children: <Widget>[
                          Expanded(
                          child:
                           Padding(
                             padding: const EdgeInsets.all(2.0),
                             child: RadioListTile(
                                title: Text(
                                  'Laki-Laki',
                                  style: TextStyle(
                                    fontSize: 8
                                  ),
                                  ),
                                value: Text("Laki-Laki"),
                                groupValue: JeniskelaminPilih,
                                onChanged: (value) {
                              },
                             ),
                           ),
                          ),
                          Expanded(
                            child:
                            RadioListTile(
                              title: Text(
                                'Perempuan',
                                style: TextStyle(
                                  fontSize: 8,
                                ),),
                              value: Text("Perempuan"),
                              groupValue: JeniskelaminPilih,
                              onChanged: (value) {                             
                              },
                            )
                          ),
                        ],
                      ),
                      */
                      SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "Sudah Punya Akun? ",
                              style: TextStyle(
                                color: Colors.blue,)
                            ),
                            TextSpan(
                                text: "Masuk",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                      // Disini Perku Adanya Pembersihan textfield pada Saat Diklik
                                    );
                                  })
                          ])),
                        ]),
                  ),
                SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Container(
                      width: 315,
                      height: 42,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff14B19E),
                            onPrimary: Colors.white,
                          ),
                          child: Center(child: Text("SIGN UP")),
                          
                          onPressed: () { setState(() { signUp(); Navigator.push( context,MaterialPageRoute(
                                    builder: (context) => AuthPage() ),
                                // Disini Perlu Adanya Pembersihan Pada Saat TextFiel Di Klik
                                // Gunakan Logika Agar Pada Saat Semua Text Fiel Belum Diisi Tidak dapat Lanjutkan halaman
                              );
                            });
                          }),
                    ),
                  ),
                ]),
              )
            ],
          )
        ]));
  }
}
