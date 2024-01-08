  import 'package:flutter/material.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'dart:convert';
  import 'package:http/http.dart' as http;

  class Profil extends StatefulWidget {
    const Profil({Key? key}) : super(key: key);

    @override
    State<Profil> createState() => _ProfilState();

  }

  class _ProfilState extends State<Profil> {

    @override
    void initState() {
      super.initState();
      loadUserSession();
    }

    Future<String> loadUserSession() async {
      String userId = await getUserIdFromPrefs();
      // String fullName = await getFullNameFromPrefs();
      // String email = await getEmailFromPrefs();
      return userId;
      // Gunakan nilai sesi pengguna sebagaimana diinginkan
      // print("$userId $fullName $email");
      // ... (lakukan apa yang diperlukan dengan data sesi pengguna)
    }

    final TextEditingController _fullnameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();


    final TextEditingController _oldpassword = TextEditingController();
    final TextEditingController _newpassword = TextEditingController();
    final TextEditingController _confirmpassword = TextEditingController();
    // String id = getUserIdFromPrefs() as String;


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(

        ),
        body: SingleChildScrollView(

          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Informasi Pengguna",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16.0),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[200],
                child: Image.asset(
                  'assets/image/orang.jpg',
                  // width: 100, // Sesuaikan dengan ukuran yang diinginkan
                  // height: 100,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                    "Nama Lengkap",style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: 500,
                child: FutureBuilder<String>(
                  future: getFullNameFromPrefs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      _fullnameController.text = snapshot.data ?? ''; // Set nilai awal dari SharedPreferences
                      return TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: 'Nama Lengkap',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        controller: _fullnameController,
                      );
                    }
                  },
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",style: TextStyle(
                    fontSize: 15,fontWeight: FontWeight.bold
                ),),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: 500,
                child: FutureBuilder<String>(
                  future: getEmailFromPrefs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      _emailController.text = snapshot.data ?? ''; // Set nilai awal dari SharedPreferences
                      return TextField(
                        readOnly: true, // Set to true to make the TextField non-editable
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        controller: _emailController,
                      );
                    }
                  },
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 10),
                width: 400,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(17, 0, 158, 1),
                  ),
                  onPressed: () async {
                    String userId = await loadUserSession(); // Use await to get the actual result
                    String newFullName = _fullnameController.text;
                    String newEmail = _emailController.text;
                    // Now you can use userId as a String
                    // print("$userId , $newEmail, $newFullName");
                    // Call the updateProfile function with the actual userId
                    await updateProfile(userId, newFullName, newEmail);
                  },
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity, // Mengatur lebar menjadi sepanjang layar
                height: 1,
                color: Colors.grey[300], // Ganti dengan warna yang diinginkan
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Ubah Password",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Password Lama",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 400,
                  child: TextField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    controller: _oldpassword,
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
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Password Baru",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 400,
                  child: TextField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    controller: _newpassword,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Password Baru',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      filled: true,
                      fillColor: Colors.grey[300],
                    ),
                  )

              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Konfirmasi Password",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 400,
                  child: TextField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    controller: _confirmpassword,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Konfirmasi Password',
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
                width: 400,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(17, 0, 158, 1),
                  ),
                  onPressed: () async {
                    String id = await loadUserSession();
                    String oldPassword = _oldpassword.text;
                    String newPassword = _newpassword.text;
                    String confirmPassword = _confirmpassword.text;
                    updatePassword(id, oldPassword, newPassword, confirmPassword);
                  },
                  child: Text(
                    "Ubah Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    Future<String> getUserIdFromPrefs() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('user_id') ?? '';
    }

    Future<String> getFullNameFromPrefs() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('full_name') ?? '';
    }

    Future<String> getEmailFromPrefs() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('email') ?? '';
    }

    Future<void> updateProfile(String userId, String newFullName, String newEmail) async {
      final url = Uri.parse('https://kgenz.site/profilAndroid');

      final Map<String, String> data = {
        'user_id': userId,
        'fullname': newFullName,
        'email': newEmail,
      };

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        String message = result['message'];
        print('Profil berhasil diubah: $message');
        _showAlertDialog(context, 'Pemberitahuan', message);
      } else {
        print('Error: ${response.body}');
      }

    }

    // Future<void> updatePassword(String userId, String oldPassword, String newPassword, String confirmPassword) async {
    //   // if(newPassword != confirmPassword) {
    //   //   _showAlertDialog(context, 'Pembaritahuan',
    //   //       'Masukkan Password Baru dan Password Lama Dengan Benar');
    //   // }else if(oldPassword == newPassword){
    //   //   _showAlertDialog(context, 'Pembaritahuan',
    //   //       'Masukkan Password Baru dan Password Lama Dengan Benar');
    //   // }else{
    //   //   final url = Uri.parse('https://c954-36-68-52-73.ngrok-free.app/profil_passwordAndroid');
    //   //
    //   //   final Map<String, String> data = {
    //   //     'user_id': userId,
    //   //     'old_password': oldPassword,
    //   //     'new_password': newPassword,
    //   //     'confirm_password' : confirmPassword,
    //   //   };
    //   //
    //   //   final response = await http.post(
    //   //     url,
    //   //     headers: <String, String>{
    //   //       'Content-Type': 'application/json; charset=UTF-8',
    //   //     },
    //   //     body: jsonEncode(data),
    //   //   );
    //   //
    //   //   if (response.statusCode == 200) {
    //   //     final Map<String, dynamic> result = jsonDecode(response.body);
    //   //     String message = result['message'];
    //   //     _showAlertDialog(context, 'Pembaritahuan',
    //   //         message);
    //   //     print('$message');
    //   //   } else {
    //   //     print('Error: ${response.body}');
    //   //   }
    //   // }
    //
    //   final url = Uri.parse('https://c954-36-68-52-73.ngrok-free.app/profil_passwordAndroid');
    //
    //   final Map<String, String> data = {
    //     'user_id': userId,
    //     'old_password': oldPassword,
    //     'new_password': newPassword,
    //     'confirm_password' : confirmPassword,
    //   };
    //
    //   final response = await http.post(
    //     url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(data),
    //   );
    //
    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> result = jsonDecode(response.body);
    //     String message = result['message'];
    //     _showAlertDialog(context, 'Pembaritahuan',
    //         message);
    //     print('$message');
    //   } else {
    //     print('Error: ${response.body}');
    //   }
    // }

    Future<void> updatePassword(String userId, String oldPassword, String newPassword, String confirmPassword) async {
      if (newPassword.isEmpty || confirmPassword.isEmpty) {
        // _showAlertDialog(context, 'Peringatan', 'Masukkan kata sandi baru dan konfirmasi kata sandi dengan benar.');
        // return;
        print("$oldPassword");
      }

      final url = Uri.parse('https://kgenz.site/profil_passwordAndroid');

      final Map<String, String> data = {
        'user_id': userId,
        'old_password': oldPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      };

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);

        // Tampilkan pesan dari server
        String message = result['message'];
        _showAlertDialog(context, 'Pemberitahuan', message);
      } else {
        print('Error: ${response.body}');
      }

      print("old password : $oldPassword");
      print("new Password : $newPassword");
      print("confirm password : $confirmPassword");

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

      // Menampilkan AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

  }
