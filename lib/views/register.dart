import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:caps/views/main.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRetypeController = TextEditingController();



  Future<void> _register(String a, String b) async {

    if(a == b){

      final response = await http.post(
        Uri.parse('https://kgenz.site/registerAndroid'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'fullname': _fullNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Registrasi berhasil
        print('Registrasi berhasil');
        _showLoginScreen();
      } else {
        // Registrasi gagal
        print('Registrasi gagal');
        print(response.statusCode);
      }
    }else{
      print("Test");
      _showAlertDialog(context, 'Warning!!','Password tidak sama!');
    }

  }

  void _showAlertDialog(BuildContext context, String title, String content) {
    // Membuat AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Tutup alert
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );

    // Panggil showDialog untuk menampilkan AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      body:
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/test.png"),
            fit: BoxFit.cover
          )
        ),
        child:
        Column(
          children: [
            Container(
              child: Image.asset("assets/image/logo.png"),
              margin: EdgeInsets.only(top: 130),
            ),
            Container(
              child: Text("Register", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Color.fromRGBO(17, 0, 158, 1),
                fontFamily: 'LeagueSpartan'

              ),),
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                width: 320,
                child: TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(

                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      filled: true,
                      fillColor: Colors.grey[200]

                  ),
                )
            ),
            // Container(
            //     margin: EdgeInsets.only(top: 5),
            //     width: 320,
            //     child: TextField(
            //       decoration: InputDecoration(
            //           contentPadding: EdgeInsets.all(10.0),
            //           hintText: 'Username',
            //           border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(20.0)
            //           ),
            //           filled: true,
            //           fillColor: Colors.grey[200]
            //
            //       ),
            //     )
            // ),
            Container(
                margin: EdgeInsets.only(top: 5),
                width: 320,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      filled: true,
                      fillColor: Colors.grey[200]

                  ),
                )
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                width: 320,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                  ),
                )

            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                width: 320,
                child: TextField(
                  controller: _passwordRetypeController,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Re-type Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],

                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 300,
              height: 50,
              child: TextButton(style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(17, 0, 158, 1),

              ),onPressed: (){
                String pass = _passwordController.text;
                String retype = _passwordRetypeController.text;
                print("$_passwordController \n  $_passwordRetypeController");
                _register(pass, retype);
              }

                ,child: Text("Submit",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),

              ),
            ),

            Center(
              child: Container(
              width: 300,
                child: Row(
                  children: [
                    Text("already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                    }, child: Text(
                      "Sign In",style: TextStyle(
                      color: Colors.blue
                    ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
