import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/component/alert.dart';
import 'package:flutter_application_cordova/page/auth_page.dart';
import 'package:flutter_application_cordova/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_cordova/utils/data.dart';

class Coba {
  int? umur;
}

// ignore: must_be_immutable
class emailSend extends StatefulWidget {
  bool suksesRegis = false;
  bool regis = false;
  bool isShowPassword = false;

  emailSend() {
    regis = Userpref.getNilai() ?? false;
  }

  @override
  State<emailSend> createState() => _emailSendState();
}

class _emailSendState extends State<emailSend> {
  String email = '';
  String password = '';
  String sekolah = '';
  String noHp = '';
  bool nextPage = false;
  bool isVisibilityTextPassword = false;
  bool isVisibilityTextSchool = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void saveData() async {
    await Userpref.setNilai(widget.regis);
  }

  Future getHasilRegistrasi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return (pref.getBool('key') ?? false);
  }

  Future<void> cekRegis() async {
    widget.suksesRegis = false;

    bool isValid = false;
    String message = "";

    await signupWithEmail(
            email: email, password: password, noHp: noHp, sekolah: sekolah)
        .then((value) =>
            {isValid = value['isValid'], message = value['message']});

    if (isValid) {
      widget.suksesRegis = true;
      widget.regis = true;
    }
    ;

    Userpref.setNilai(true);

    (widget.suksesRegis)
        ? AlertSystem.successAlert(context, text: message, page: "/home")
        : showAlertWarning(message);
  }

  void showAlertWarning(String text) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: '',
        widget: Column(
          children: [
            Container(
              width: 230,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 15)),
              ),
            )
          ],
        ),
        barrierDismissible: false,
        titleColor: Color.fromRGBO(0, 0, 0, 1),
        confirmBtnText: 'Okay');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => AuthPage())));
        return true;
      },
      child: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 400,
              //padding: EdgeInsets.all(10),
              child: Image.asset('gambar/register1.png'),
            ),
            Container(
              margin: EdgeInsets.only(left: 35),
              child: Text('Registrasi',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold))),
            ),
            Container(
              margin: EdgeInsets.only(left: 35, right: 10),
              child: Text(
                'Regristrasi dulu yuk! Sebelum belajar buat teknologi',
                style: GoogleFonts.poppins(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 280,
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: TextField(
                onChanged: ((value) {
                  setState(() {
                    email = value.toString();
                  });
                }),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color.fromARGB(255, 255, 240, 245),
                  filled: false,
                  labelText: 'Email kamu',
                  floatingLabelStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15)),
                  prefixIcon: Icon(Icons.email,
                      color: Color.fromARGB(253, 215, 5, 124)),
                  labelStyle: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Container(
              height: 60,
              width: 280,
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: !widget.isShowPassword,
                onChanged: ((value) {
                  setState(() {
                    password = value.toString();
                    isVisibilityTextPassword = value.isNotEmpty;
                  });
                }),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color.fromARGB(255, 255, 240, 245),
                  filled: false,
                  floatingLabelStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15)),
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 12),
                  prefixIcon:
                      Icon(Icons.lock, color: Color.fromARGB(253, 215, 5, 124)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        widget.isShowPassword = !widget.isShowPassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisibilityTextPassword,
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 10),
                child: Text('Gunakan password minimal 8 huruf',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 10))),
              ),
            ),
            Container(
              height: 60,
              width: 280,
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: TextField(
                onChanged: ((value) {
                  setState(() {
                    noHp = value.toString();
                  });
                }),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color.fromARGB(255, 255, 240, 245),
                  filled: false,
                  labelText: 'Nomor Handphone',
                  floatingLabelStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15)),
                  labelStyle: TextStyle(fontSize: 12),
                  prefixIcon: Icon(Icons.phone,
                      color: Color.fromARGB(253, 215, 5, 124)),
                ),
              ),
            ),
            Container(
              height: 60,
              width: 280,
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: TextField(
                onChanged: ((value) {
                  setState(() {
                    sekolah = value.toString();
                    isVisibilityTextSchool = true;
                  });
                }),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color.fromARGB(255, 255, 240, 245),
                  filled: false,
                  labelText: 'Asal sekolah / Universitas',
                  floatingLabelStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15)),
                  labelStyle: TextStyle(fontSize: 12),
                  prefixIcon: Icon(Icons.school,
                      color: Color.fromARGB(253, 215, 5, 124)),
                ),
              ),
            ),
            Visibility(
              visible: isVisibilityTextSchool,
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 10),
                child: Text(
                    'Asal sekolah isi dengan tanda (-) jika bukan pelajar',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 10))),
              ),
            ),
            Container(
              height: 50,
              width: 300,
              margin: EdgeInsets.only(bottom: 20, left: 20, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  cekRegis();
                },
                child: Text(
                  'Kirim',
                  style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Color.fromARGB(253, 215, 5, 124)),
              ),
            )
          ],
        ),
      )),
    );
  }

  FutureOr<void> afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    throw UnimplementedError();
  }
}
