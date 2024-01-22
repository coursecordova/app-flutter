import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/page/email_register_page.dart';
import 'package:flutter_application_cordova/utils/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_cordova/intro.dart';
import 'package:flutter_application_cordova/navigation%20bar.dart';
import 'package:flutter_application_cordova/page/new_password_page.dart';
import 'package:flutter_application_cordova/page/reset_page.dart';
import 'package:flutter_application_cordova/page/reset_validator_page.dart';
import 'package:flutter_application_cordova/page/signin_page.dart';
import 'package:flutter_application_cordova/page/auth_page.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Userpref.init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp();
  var a = emailSend();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/login': ((context) => SigninPage()),
          '/reset_password': ((context) => ResetPage()),
          '/reset_token_validator': ((context) => ResetValidatorPage()),
          '/new_password': ((context) => NewPasswordPage()),
          '/home': ((context) => NavigasiBar()),
        },
        home: Splash(a));
  }
}

// CourseInformationPage(courseId: 1,)

// Splash(a)