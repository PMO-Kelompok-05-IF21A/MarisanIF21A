import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/Home.dart';
import 'package:marisanif21a/pages/Login.dart';



class terimakasih extends StatelessWidget {
  terimakasih({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 222,),
              Image.asset(
                "assets/images/tick.png"
                ,
                 width: 150, height: 150,),
              SizedBox(height: 38,),
              Text("Terima Kasih!", style: TextStyle(fontSize: 28, fontFamily: 'RobotoBold',  color: Color(0xFF14B19E)),
              textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Text("Kamu telah berhasil mendaftar", style: TextStyle(fontSize: 20, fontFamily: 'Roboto', color: Color(0xFF14B19E)),
              textAlign: TextAlign.center,),
              SizedBox(height: 5),
              Text(user.email!, style: TextStyle(fontSize: 15, fontFamily: 'Roboto', color: Color(0xFF14B19E)),
              textAlign: TextAlign.center,),
              SizedBox(height: 5),
              SizedBox(height: 150),
              Padding(
                padding: const EdgeInsets.only(left:16.0,right:16),
                child: Container(
                  width: 315,
                  height: 42 ,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff14B19E),
                      onPrimary: Colors.white,
                    ),
                  child: Center(child: Text("Home")),
                  onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage())
                  );
                  }
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                    Text("Melanjutkan anda perlu", style: TextStyle(fontSize: 15, fontFamily: 'Roboto'
                    ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                     child:  Text("Masuk", style:  TextStyle(fontSize: 15, fontFamily: 'Roboto', color: Colors.blue),)
                     )
                ],

              )
              
              
              ],
              
          ),
        ),
      )
    );
  }
}