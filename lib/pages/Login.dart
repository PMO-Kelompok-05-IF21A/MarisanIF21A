import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marisanif21a/pages/Home.dart';
import 'SignUp.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// text editing controllers
bool _obscureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // sign user in method
  void signUserIn() async {
    // loading 
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // showeror
      ShowerorMessage(e.code);
     
    }
  }

  // eror message
  void ShowerorMessage(String message){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff14B19E),
          title: Center(
            child: Text(
              message,
              style:const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff14B19E)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          }
         ),
      ),
      body:ListView( 
        children: <Widget> [
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left:16.0,top: 20),
            child: Text(
            "Selamat Datang!",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color:(Color(0xff14B19E)),
             ),
                   ),
          ),
         SizedBox(height: 5.0),
         Padding(
           padding: const EdgeInsets.only(left:16.0,top: 15.0),
           child: Text(
            "Marisan Siap di mulai!"
            "\nMasukan Nama dan Sandi Untuk Masuk",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              fontFamily: "Roboto",
              color: Color(0xff14B19E),),
            ),
         ),
          SizedBox(height:00.0),
          Padding(
            padding: const EdgeInsets.only(left:16.0,top: 25, right: 16),
            child: SizedBox(
              height:56,
              width: 315,
              child: TextField(
                cursorColor: Color(0xff14B19E),
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff14B19E))
                  ),
                  labelText: 'Email'
                )
              ),
            ),
          ),
          SizedBox(),
                Padding(
                  padding: 
                  const EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: TextField(
                    cursorColor: Color(0xff14B19E),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                       borderSide: BorderSide( color : Color(0xff14B19E) )
                      ),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Color(0xff14B19E),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    controller: passwordController,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(left:200.0,top: 20.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "Akun Baru "),
                  TextSpan(
                    text: "Buat Akun!",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => signUp()),
                      );
                    }
                  )
                ]
              )),
          ),
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
                  child: Center(child: Text("LOGIN")),

                  onPressed: () { setState(() { signUserIn(); Navigator.push( context,MaterialPageRoute(
                                  builder: (context) => Homepage() ),
                            );
                          });
                       }),
                ),
              ),
       ]   
     ),
    );
  }
}