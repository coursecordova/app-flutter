import 'package:flutter/material.dart';
class erroHandler extends StatefulWidget {
  const erroHandler({super.key});

  @override
  State<erroHandler> createState() => _erroHandlerState();
}

class _erroHandlerState extends State<erroHandler> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('gambar/error.png'),
            Text(
              'Upss! tidak bisa mengakses. Pastikan jaringan terkoneksi ke internet',
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
