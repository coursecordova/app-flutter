import 'package:flutter_application_cordova/utils/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/page/email_register_page.dart';
import 'package:flutter_application_cordova/navigation bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_application_cordova/page/auth_page.dart";
import 'package:after_layout/after_layout.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class Asal {
  static String a = 'indra';
}

// ignore: must_be_immutable
class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
  bool getHasilRegis = false;

  Splash(emailSend a) {
    getHasilRegis = a.regis;
  }
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  bool c = false;

  Future checkFirstSeen() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    bool isLogin = (prefs.getBool('home') ?? false);

    if (_seen) {
      if (isLogin) {
        await Userpref.setIsLogin(true);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => NavigasiBar()));
      } else {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => AuthPage()));
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => intro()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.asset('gambar/logos.png'),
            ),
            Container(
                child: Lottie.asset('gambar/robot.json',
                    width: 300, height: 400, fit: BoxFit.fill)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Kursus Coding Pelajar',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(253, 215, 5, 124))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class intro extends StatelessWidget {
  Widget buildgambar(String temp) => Container(
        margin: EdgeInsets.only(top: 50),
        child: Image.asset(
          temp,
        ),
      );

  PageDecoration dekorPage() => PageDecoration();

  DotsDecorator dekorDots() => DotsDecorator(
      activeColor: Color.fromARGB(253, 215, 5, 124),
      size: const Size.square(10.0),
      activeSize: const Size(20.0, 10.0),
      color: Colors.black26,
      spacing: const EdgeInsets.symmetric(horizontal: 3.0),
      activeShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)));

  PageViewModel design(gambar, titel, desc, last) => PageViewModel(
        title: '',
        bodyWidget: Column(
          children: [
            buildgambar(gambar),
            Text(
              titel,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(253, 215, 5, 124)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 15, color: Color.fromARGB(252, 196, 0, 110)),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionScreen(
        globalHeader: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: Image.asset("gambar/logos.png"),
            )
          ],
        ),
        pages: [
          design(
              "gambar/tutor1.png",
              'Langsung dengan tutor',
              'Dibimbing langsung oleh para praktisi ahli di bidangnya dan dengan pengalaman mengajar',
              false),
          design(
              "gambar/certificate1.png",
              'Bersertifikat',
              'Dapatkan sertifikat resmi kami dan bangun masa depan kamu',
              false),
          PageViewModel(
            title: '',
            bodyWidget: Column(
              children: [
                buildgambar(
                  "gambar/terjangkau.png",
                ),
                Text('Terjangkau',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(253, 215, 5, 124)),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                      'Biaya terjangkau, cocok bagi kamu yang masih pelajar',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(252, 196, 0, 110)),
                      )),
                ),
              ],
            ),
          )
        ],
        globalFooter: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AuthPage(),
              ));
            },
            child: Text(
              'Mulai',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(253, 215, 5, 124),
                shape: StadiumBorder(),
                fixedSize: Size(200, 50)),
          ),
        ),
        done: Text('Masuk'),
        showDoneButton: false,
        globalBackgroundColor: Color.fromARGB(255, 255, 204, 249),
        next: Icon(
          Icons.arrow_circle_right,
          color: Colors.black,
        ),
        dotsDecorator: dekorDots(),
        showSkipButton: false,
        showNextButton: false,
        skip: Text(
          'Skip',
          style: TextStyle(color: Colors.black),
        ),
        onDone: (() {}),
      ),
    );
  }
}
