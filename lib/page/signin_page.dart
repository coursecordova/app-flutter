import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/component/alert.dart';
import 'package:flutter_application_cordova/page/auth_page.dart';
import 'package:flutter_application_cordova/utils/data.dart';
import 'package:flutter_application_cordova/page/reset_page.dart';
import 'package:flutter_application_cordova/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String email = '';
  String password = '';
  bool isShowPassword = false;
  bool isVisibilityTextPassword = false;
  bool isVisibilityTextSchool = false;

  // login logic
  Future<void> loginAccount() async {
    bool isValid = false;
    String message = "";
    await loginWithEmail(email: email, password: password).then(
        (value) => {isValid = value['isValid'], message = value['message']});

    Userpref.setNilai(true);

    isValid
        ? AlertSystem.successAlert(context, text: message, page: "/home")
        : AlertSystem.warningAlert(context, text: message);
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
                height: 300,
                width: 400,
                child: Image.asset("gambar/login-animated.gif"),
              ),
              Container(
                margin: EdgeInsets.only(left: 35),
                child: Text('Login',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
              ),
              Container(
                margin: EdgeInsets.only(left: 35, right: 10),
                child: Text(
                  'Login dulu yuk! Untuk masuk akun mu',
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
                  obscureText: !isShowPassword,
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
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromARGB(253, 215, 5, 124)),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
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
                margin: EdgeInsets.only(right: 30),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ResetPage()));
                    },
                    child: Text(
                      "Lupa Password?",
                      style: TextStyle(color: Color.fromARGB(253, 215, 5, 124)),
                    ),
                  )
                ]),
              ),
              Container(
                height: 50,
                width: 300,
                margin: EdgeInsets.only(bottom: 20, left: 20, top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    loginAccount();
                  },
                  child: Text(
                    'Login',
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
