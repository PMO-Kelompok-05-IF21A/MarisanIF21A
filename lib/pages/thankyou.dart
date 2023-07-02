import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/login.dart';

class terimakasih extends StatelessWidget {
  const terimakasih({super.key});

  //kocakk
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
                'assets/images/tick.png',
                 width: 150, height: 150,),
              SizedBox(height: 38,),
              Text("Terima Kasih!", style: TextStyle(fontSize: 28, fontFamily: 'RobotoBold',  color: Color(0xFF14B19E)),
              textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Text("Kamu telah berhasil mendaftar", style: TextStyle(fontSize: 20, fontFamily: 'Roboto', color: Color(0xFF14B19E)),
              textAlign: TextAlign.center,),
              SizedBox(height: 5),
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