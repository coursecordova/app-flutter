import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_application_cordova/navigation bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_application_cordova/data.dart';

class Coba {
  int? umur;
}

class emailSend extends StatefulWidget {
  bool suksesRegis = true;
  bool regis = false;

  emailSend() {
    regis = Userpref.getNilai() ?? false;
  }

  @override
  State<emailSend> createState() => _emailSendState();
}

class _emailSendState extends State<emailSend> {
  String nama = '';
  String sekolah = '';
  String noHp = '';
  String email = '';
  bool nextPage = false;

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

  void cekRegis() {
    widget.suksesRegis = false;
    if (nama != '') {
      if (noHp != '') {
        if (noHp.length > 10 && noHp.length <= 14) {
          if (sekolah != '' && sekolah.length > 3 || sekolah == '-') {
            widget.suksesRegis = true;
            widget.regis = true;
            kirimEmail();
          }
        }
      }
    }
  }

  kirimEmail() async {
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    String username = 'tiktokcordova9@gmail.com';
    String password = 'fvsllpmmdjbicudm';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'indra')
      ..recipients.add('admin@cordovacourse.com')
      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>Test</h1>\n<p>Nama : $nama</p>\n<p>Sekolah : $sekolah</p>\n<p>No. Hp : $noHp</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // //
  }

  void showAlertSukses() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      barrierDismissible: false,
      confirmBtnText: 'Mulai',
      title: '',
      widget: Column(
        children: [
          Container(
            width: 230,
            child: Text(
              'Berhasil!',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 230,
            child: Text(
              'Ayo! Mulai buat teknologi!',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
      onConfirmBtnTap: () {
        setState(() {
          Navigator.of(context).pop();
          Future.delayed(Duration(seconds: 1));
           Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const NavigasiBar(),
      ));
        });
      },
    );
  }

  pindahPage() {
    if (nextPage) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const NavigasiBar(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    void showAlertWarning() {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: '',
          widget: Column(
            children: [
              Container(
                width: 230,
                child: Text(
                  'Data kamu gak valid nih, Mohon isi dengan benar',
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

    return MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: 500,
              padding: EdgeInsets.all(10),
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
                    nama = value.toString();
                  });
                }),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color.fromARGB(255, 255, 240, 245),
                  filled: false,
                  labelText: 'Nama lengkap kamu',
                  floatingLabelStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15)),
                  prefixIcon: Icon(Icons.person,
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
                keyboardType: TextInputType.phone,
                onChanged: ((value) {
                  setState(() {
                    noHp = value.toString();
                  });
                }),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color.fromARGB(255, 255, 240, 245),
                  filled: false,
                  floatingLabelStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15)),
                  labelText: 'Nomor telepon kamu',
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
            Container(
              margin: EdgeInsets.only(left: 35, right: 10),
              child: Text(
                  'Asal sekolah isi dengan tanda (-) jika bukan pelajar',
                  style:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 10))),
            ),
            Container(
              height: 50,
              width: 300,
              margin: EdgeInsets.only(bottom: 20, left: 20, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cekRegis();
                    saveData();
                    (widget.suksesRegis)
                        ? showAlertSukses()
                        : showAlertWarning();
                  });
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

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    throw UnimplementedError();
  }
}
