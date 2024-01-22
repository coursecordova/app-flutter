import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/component/alert.dart';
import 'package:flutter_application_cordova/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  String email = '';

  Future resetPassword() async {
    bool isValid = false;
    String message = "";
    await resetPasswordEmail(email: email).then(
        (value) => {isValid = value['isValid'], message = value['message']});

    isValid
        ? AlertSystem.successAlert(context,
            text: message, page: '/reset_token_validator')
        : AlertSystem.warningAlert(context, text: message);

    // save to cache
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("email", email);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(30, screenHeigth * 0.1, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Reset sandi",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w700)),
                  ),
                  Text(
                    "Masukkan email yang terkait dengan akun Anda dan kami akan mengirimkan email untuk mereset sandi",
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.roboto(textStyle: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
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
              height: 50,
              width: 300,
              margin: EdgeInsets.only(bottom: 20, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text(
                  'Reset sandi',
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
      ),
    );
  }
}
