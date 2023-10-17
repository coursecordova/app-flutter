import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/email%20regis.dart';
import 'package:flutter_application_cordova/intro.dart';
import 'package:flutter_application_cordova/data.dart';


Future main()  async{
  WidgetsFlutterBinding.ensureInitialized();
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
      home: Splash(a),
    );
  }
}

       