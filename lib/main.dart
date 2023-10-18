import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/email%20regis.dart';
// import 'package:flutter_application_cordova/intro.dart';
import 'package:flutter_application_cordova/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// page
import 'page/auth_page.dart';


Future main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Userpref.init();
  runApp(MyApp());
} 
  
class MyApp extends StatelessWidget {
  MyApp();
  var a = emailSend();
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

// Splash(a)