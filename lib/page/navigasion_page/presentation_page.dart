import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/component/alert.dart';
import 'package:flutter_application_cordova/component/presentation_card.dart';
import 'package:google_fonts/google_fonts.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                AlertSystem.infoAlert(context);
              }),
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ))
        ],
        title: Text(
          'Pengenalan coding',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(color: Colors.white, fontSize: 17)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFEF2D74),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Column(
          children: [
            PresentationCard(
                gambar: 'gambar/slide1.png',
                judul: 'Definisi coding',
                desc:
                    'Disini ada yang tau coding?\nKalo engga yuk kenalan dulu apa itu coding',
                tautan: 'https://mywebar.com/p/Project_9_d6jj74dbh9'),
            PresentationCard(
                gambar: 'gambar/slide2.png',
                judul: 'Profesi dengan coding',
                desc: 'Berikut beberapa profesi yang kerjanya\npakai codingan',
                tautan: 'https://mywebar.com/p/Project_9_d6jj74dbh9'),
            PresentationCard(
                gambar: 'gambar/slide3.png',
                judul: 'Alasan belajar coding',
                desc:
                    'Alasan mengapa kamu harus belajar coding\ndi era sekarang',
                tautan: 'https://mywebar.com/p/Project_9_d6jj74dbh9'),
            PresentationCard(
                gambar: 'gambar/slide4.png',
                judul: 'Kata mereka',
                desc:
                    'Beberapa orang hebat yang bilang belajar\ncoding itu sangat penting',
                tautan: 'https://mywebar.com/p/Project_9_d6jj74dbh9'),
            PresentationCard(
                gambar: 'gambar/slide5.png',
                judul: 'Orang sukses',
                desc: 'Orang-orang sukses yang belajar coding\nsiapa aja sih?',
                tautan: 'https://mywebar.com/p/Project_9_d6jj74dbh9'),
          ],
        ),
      ),
    );
  }
}
