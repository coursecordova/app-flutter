import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/component/alert.dart';
import 'package:flutter_application_cordova/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool isVisibilityTextPassword = false;
  String password = "";

  Future<void> setNewPassword(String password) async {
    bool isValid = false;
    String message = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = await prefs.getString('email');

    await changePassword(emailData: email, password: password).then(
        (value) => {isValid = value['isValid'], message = value['message']});

    isValid
        ? AlertSystem.successAlert(context, text: message, page: "/login")
        : AlertSystem.warningAlert(context, text: message);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeigth * 0.1),
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
                      "Masukkan sandi baru anda untuk merubah sandi pada akun anda",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 16)),
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
                child: TextField(
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
                    labelText: 'sandi',
                    floatingLabelStyle:
                        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15)),
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromARGB(253, 215, 5, 124)),
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: isVisibilityTextPassword,
                  child: Container(
                    margin: EdgeInsets.only(left: 35),
                    child: Text('Gunakan password minimal 8 huruf',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 10))),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 300,
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    setNewPassword(password);
                  },
                  child: Text(
                    'Reset sandi',
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Color.fromARGB(253, 215, 5, 124)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
