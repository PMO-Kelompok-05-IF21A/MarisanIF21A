import 'package:flutter/material.dart';

class congrat extends StatelessWidget {
  const congrat({super.key, required String selectedName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 50, top: 150, right: 50),
            width: 200,
            height: 200,
            child: Image.asset(
              "asset/images/111.png",
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, top: 25, right: 16),
            constraints: BoxConstraints(
              maxHeight: 239,
            ),
            child: 
            RichText(
              textAlign: TextAlign.center,
              text:
              TextSpan(
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  letterSpacing: -0.16500000066,
                  color: Color.fromRGBO(20, 177, 158, 1)
                ),
                children: [
                  TextSpan(
                    text: "Nama", // Diisi Dengan Nama Yang Diambil Dari Inputan dari Pemenang.
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height:1.5,
                      letterSpacing: -0.16500000066,
                      color: Color.fromRGBO(20, 177, 158, 1),
                    ),
                  ),
                  TextSpan(
                    text: "\nSelamat Anda Memenangkan Arisan Ini\n",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 2.5714285714,
                      letterSpacing: -0.1650000066,
                      color: Color.fromRGBO(20, 177, 158, 1)

                    )
                  )

                ]
              )),
          ),
          Container(
            // group12770KhM (62:756)
            margin:  EdgeInsets.only(left:16,top: 80, right: 16),
            child:  
         TextButton(
            onPressed:  () {},
            style:  TextButton.styleFrom (
              padding:  EdgeInsets.zero,
            ),
            child:  
          Container(
            width:  315,
            height:  52,
            decoration:  BoxDecoration (
              color:  Color(0xff14b19e),
              borderRadius:  BorderRadius.circular(7),
            ),
            child:  
          Center(
            child:  
          Text(
            'Home',
            textAlign:  TextAlign.center,
            style:  TextStyle(
              fontFamily: 'Roboto',
              fontSize:  15,
              fontWeight:  FontWeight.w700,
              height:  1.5,
              color:  Color(0xffffffff),
            ),
          ),
         ),
        ),
        ),
      ),
      ],
      ),
    );
  }
}