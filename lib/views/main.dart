import 'dart:convert';

import 'package:caps/views/artikelrujukan.dart';
import 'package:caps/views/home_page.dart';
import 'package:caps/views/layanan.dart';
import 'package:caps/views/menu.dart';
import 'package:caps/views/profil.dart';
import 'package:caps/views/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


void main(){
    runApp(

      MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home()
  ));
}

class Home extends StatefulWidget {
  // const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

    // Menampilkan AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> saveUserSession(String userId, String fullName, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
    prefs.setString('full_name', fullName);
    prefs.setString('email', email);
  }


  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('https://kgenz.site/loginAndroid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Parsing data JSON dari respons server
      Map<String, dynamic>? userData = json.decode(response.body);

      if (userData != null && userData.containsKey('fullname') && userData.containsKey('email')) {
        final userId = userData['user_id'].toString();
        final fullName = userData['fullname'] as String?;
        final email = userData['email'] as String?;

        print("${userId} ${fullName} ${email}");
        // Simpan sesi pengguna dengan data dari database
        saveUserSession(userId!, fullName!, email!);

        // Arahkan ke layar berikutnya
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Beranda()),
        );
      } else {
        // Data pengguna tidak ditemukan atau tidak sesuai dengan harapan
        print('Invalid user data format');
      }
    } else if (response.statusCode == 401) {
      // Invalid email or password, show an error message
      print('Invalid email or password');
      _showAlertDialog(context, 'Pemberitahuan', 'Email atau Password salah');
    } else {
      // Other errors, handle accordingly
      print('Error: ${response.body}');
    }
  }





  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,



      body:
      Container(

          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/test.png"),
                fit: BoxFit.cover),

          ),
          child:
            Container(

              child:
                Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Text("adasad"),
                  )
                  ,

                  Container(
                    child: Image.asset("assets/image/logo.png"),
                    margin: EdgeInsets.only(top: 150),
                  ),
                  Container(
                    child:
                      Text("Jangan Biarkan Diri Anda Sendirian. Bersama, Kita Peduli",style: TextStyle(fontSize: 14),),
                      margin: EdgeInsets.only(top: 5),



                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 250,

                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 250,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),

                            ),

                            filled: true,
                            fillColor: Colors.grey[350]

                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 250,
                      child: TextField(
                        controller: passwordController,
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
                    margin: EdgeInsets.only(top: 10),
                    width: 250,


                    child: Center(
                      child: Row(
                        children: [

                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [

                                // Container(
                                //   child: const Align(
                                //     alignment: Alignment.topLeft,
                                //     child: Text("Don't have an account?"),
                                //
                                //   )
                                // ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text("Don't Have An Account?"),
                                      ),
                                      Container(
                                        child: TextButton(
                                          onPressed: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => register()));
                                          }

                                          ,
                                          child: Text("Sign up"
                                          ,style: TextStyle(
                                              color: Colors.blue
                                            ),),
                                        ),
                                      )

                                    ],
                                  ),

                                ),

                              ],
                            ),


                          ),
                          Expanded(



                            child: TextButton(

                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[900]),
                              onPressed:
                              _login,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child:
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.lightBlue[900],
                              height: 50,
                            )),
                      ),
                      Text("OR", style:
                        TextStyle(
                          color: Colors.lightBlue[900],
                          fontSize: 20.0
                        ),),
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.lightBlue[900],
                              height: 50,
                            )),
                      ),
                    ]),
                  ),
                  Container(

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/google_logo.png"),
                              height: 25.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  )

                ],

              ),

              // Foreground widget here
            )
      )
    );
  }
}

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
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

    // Menampilkan AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Image.asset(
          "assets/image/logo.png",
          height: 40,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white, // Ganti warna sesuai kebutuhan
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.exit_to_app,
                color: Colors.lightBlue[900],
              ),
            ),
          ),InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profil()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.person,
                color: Colors.lightBlue[900], // Ganti warna sesuai kebutuhan
              ),
            ),
          ),
        ],

      ),
      body:
        Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text("Call-to-Action", style:
                    TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'LeagueSpartan',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(17, 0, 158, 1),

                    ),),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text("\"Jaga Kesehatan Mentalmu Mulai Sekarang\"",
                      style:
                        TextStyle(
                          color: Color.fromRGBO(17, 0, 158, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 15

                        ),),
                    ),
                    Container(
                      width: 280,
                      padding: EdgeInsets.only(bottom: 9),
                      child:
                      Image.asset("assets/image/calltoaction.png"),
                    )

                  ],
                ),
              ),

              Flexible(flex: 1,child: Container(
                padding: EdgeInsets.only(top: 10),
                width: double.infinity,

                decoration: new BoxDecoration(color: Color.fromRGBO(17, 0, 158, 1)),
                child: Column(
                  children: [
                    Container(

                      child: Text("Layanan Unggulan", style:
                      TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25
                      ),),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child:
                      Image.asset("assets/image/gambarunggulan.png"),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("Teknik Relaksasi", style:
                      TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25
                      ),),
                    ),
                    Container(
                      child: TextButton(

                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Layanan()));
                        },
                        child: Text(
                          "Lanjut Ke Halaman Selanjutnya",
                          style: TextStyle(
                              color:Color.fromRGBO(17, 0, 158, 1)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))


            ],
          ),

          ),
        );

    // );
  }
}






