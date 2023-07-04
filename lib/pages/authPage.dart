import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/Login.dart';
import 'package:marisanif21a/pages/Selamat.dart';
import 'package:marisanif21a/pages/awal.dart';
import 'package:marisanif21a/pages/thankyou.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //berhasil login
          if (snapshot.hasData) {
            return terimakasih();
          }

          // tidak login
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
