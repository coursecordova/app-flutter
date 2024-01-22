import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/page/signin_page.dart';
import 'package:flutter_application_cordova/utils/google_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_cordova/page/email_register_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with RouteAware {
  bool isLoading = true;

  void navToLoginPage(context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => emailSend()));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Pop Screen Disabled. You cannot go to previous screen.'),
            backgroundColor: Colors.red,
          ),
        );

        return false;
      },
      child: Scaffold(
        body: isLoading
            ? Center(
                child: SpinKitRing(
                  color: Color.fromARGB(253, 215, 5, 124),
                  size: 75.0,
                ),
              )
            : Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 50, 25, 0),
                    child: Column(
                      children: [
                        Container(
                          // margin: EdgeInsets.only(top: 200),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                // padding: EdgeInsets.only(top: 5),
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.centerLeft,
                                child: Image(
                                  image: AssetImage("gambar/applogo2.png"),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 100,
                                child: Text("Masuk",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold))),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  GoogleService().googleSignIn(context);
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(FontAwesomeIcons.google),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Masuk dengan Google',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    backgroundColor:
                                        Color.fromARGB(253, 215, 5, 124),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("atau"),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SigninPage(),
                                  ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Color.fromARGB(253, 215, 5, 124),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Masuk dengan Email",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  253, 215, 5, 124),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        side: BorderSide(
                                            color: Color.fromARGB(
                                                253, 215, 5, 124),
                                            width: 2)),
                                    backgroundColor: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Belum punya akun?"),
                              TextButton(
                                  child: Text("Buat dulu yuk!!"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => emailSend(),
                                    ));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(253, 215, 5, 124),
                                  ))
                            ])),
                  ])
                ],
              ),
      ),
    );
  }
}
