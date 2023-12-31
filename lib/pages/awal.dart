import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/authPage.dart';
class awal extends StatelessWidget {
  const awal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
          padding: EdgeInsets.all(20),
          child: Image.asset(
          "assets/images/Group_12795.png",
          height: 365,
          width: 375,
          alignment: Alignment.center,
          ),
       ),
       Column(
        children:<Widget> [
          Container(
          width: 35.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
          "MARISAN",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
            color:(Color.fromRGBO(20, 177, 158, 1)),
              ),
             ),
             Text(
          "Merupakan aplikasi arisan yang"
          "\nmembantu dalam pendataan arisan" 
          "\npengelolaan uang dan member",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Roboto",
            color:(Color.fromRGBO(20, 177, 158, 1)),
               ),
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
           // textAlign Digunakan Untuk Membuat Tampilan Tulisan Berada disisi Kiri
              ),
              SizedBox(height: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              Container(
                width: 315,
                height: 42 ,
                child: 
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(20, 177, 158, 1),
                    onPrimary: Colors.white,
                  ),
                child: Center(child: Text("OPEN")),
                // Font Belum Diubah ke "ROBOTO" dan FontSize BOLD
                onPressed: () {
                  // Gunakan Cara Agar Button Ini pindah Menuju Ke Halaman Login Page
                  Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => AuthPage()),// aUTH
                  );
                }
                ),
              ),
             ],       
            ),
          ]
         ),  
        /* Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          
        )
         )
         */
        ]
      ),
      
      
    );
  }
}