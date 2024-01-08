
import 'package:caps/views/artikelrujukan.dart';
import 'package:caps/views/chabot.dart';
import 'package:caps/views/home_page.dart';

import 'package:caps/views/main.dart';
import 'package:caps/views/profil.dart';
import 'package:caps/views/sentimen_analisis.dart';
import 'package:flutter/material.dart';

class Layanan extends StatelessWidget {
  const Layanan({super.key});

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
                color: Colors.lightBlue[900], // Ganti warna sesuai kebutuhan
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
              child: Container(
                child: GridView.count(crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child:
                      Image.asset("assets/image/tanganhp.png"),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 50),
                            alignment: Alignment.center,
                            child:
                            Text("menunjukkan kecakapan chat bot dalam berkomunikasi", textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(17, 0, 158, 1)
                            ),),
                          ),
                          Container(
                            width: 180,
                            child: TextButton(

                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[900]),
                              onPressed: () {

                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatBotPanel()));
                              },
                              child: Text(
                                "Open Chatbot",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),



                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 45),
                            alignment: Alignment.center,
                            child:
                            Text("Analisis Ekspresi Wajah untuk Mendeteksi Emosi", textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(17, 0, 158, 1)
                            ),),
                          ),
                          Container(
                            width: 180,
                            child: TextButton(

                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[900]),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyPage()));
                              },
                              child: Text(
                                "Open Analisis Ekspresi",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child:
                      Image.asset("assets/image/robot.png"),
                    ),
                    Container(
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child:
                        Image.asset("assets/image/human.png")
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 50),
                            alignment: Alignment.center,
                            child:
                            Text("Rekomendasi Artikel dan Latihan Relaksasi", textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(17, 0, 158, 1)
                            ),),
                          ),
                          Container(
                            width: 180,
                            child: TextButton(

                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[900]),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => artikelRujukan()));
                              },
                              child: Text(
                                "Open Artikel",
                                style: TextStyle(
                                  color: Colors.white,

                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      // margin: EdgeInsets.all(5),
                      // alignment: Alignment.center,
                      // child:
                      // Text("Rekomendasi Artikel dan Latihan Relaksasi", textAlign: TextAlign.center,style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.bold,
                      //     color: Color.fromRGBO(17, 0, 158, 1)
                      // ),),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 45),
                            alignment: Alignment.center,
                            child:
                            Text("Analisis Sentimen", textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(17, 0, 158, 1)
                            ),),
                          ),
                          Container(
                            width: 180,
                            child: TextButton(

                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[900]),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => sentimen()));
                              },
                              child: Text(
                                "Open Analisis Sentimen",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child:
                      Image.asset("assets/image/analisis1.png"),
                    ),
                  ],),

              )
          )

    );
  }
}
