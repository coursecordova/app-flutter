import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quickalert/quickalert.dart';

class Presetasi extends StatefulWidget {
  const Presetasi({super.key});

  @override
  State<Presetasi> createState() => _PresetasiState();
}

class _PresetasiState extends State<Presetasi> {
  bool munculAlert = true;
  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showAlertinfo() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: '',
        widget: Container(
            child: Column(
          children: [
            Container(
              width: 230,
              child: Text(
                'INFO',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 230,
              child: Text(
                  '''Page ini berisi pengenalan coding yang diracik dengan Teknlogi Augmented Reality (AR). 
\nKamu perlu beberapa persiapan untuk memakai teknologi ini. Berikut diantaranya:''',
                   style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(fontSize: 15))),
            ), 
            SizedBox(height: 10,),
            Row(children: [
              Icon(Icons.network_wifi, color: Colors.green,),
              SizedBox(width: 5,),
              Container(
                child: Text('Koneksikan jaringan ke internet',softWrap: true,style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontSize: 15))),
              )
            ],),
            Row(children: [
              Icon(Icons.camera_enhance, color: Colors.redAccent,),
              SizedBox(width: 5,),
              Container(
                child: Text('Izinkan akses kamera pada\nbrowser kamu',softWrap: true,style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontSize: 15))),
              )
            ],)
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    Container buildCard(gambar, judul, desc, tautan) {
      return Container(
        child: Card(
          elevation: 1,
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 110,
                width: 100,
                color: Colors.amber,
                child: Image.asset(
                  gambar,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      judul,
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    margin: EdgeInsets.only(left: 7, bottom: 5, top: 10),
                  ),
                  Container(
                    child: Text(
                      desc,
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 10)),
                    ),
                    padding: EdgeInsets.only(right: 20),
                    margin: EdgeInsets.only(
                      bottom: 5,
                      left: 7,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 7),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(253, 215, 5, 124)),
                        onPressed: () {
                          setState(() {
                            _launchURL(tautan);
                          });
                        },
                        child: Row(
                          children: [Icon(Icons.play_arrow), Text("Play")],
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: showAlertinfo,
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
          backgroundColor: Color.fromARGB(255, 192, 34, 89),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child: Column(
            children: [
              buildCard(
                  'gambar/slide1.png',
                  'Definisi coding',
                  'Disini ada yang tau coding?\nKalo engga yuk kenalan dulu apa itu coding',
                  'https://mywebar.com/p/Project_9_d6jj74dbh9'),
              buildCard(
                  'gambar/slide2.png',
                  'Profesi dengan coding',
                  'Berikut beberapa profesi yang kerjanya\npake coding',
                  'https://mywebar.com/p/Project_10_a8xr962d5n'),
              buildCard(
                  'gambar/slide3.png',
                  'Alasan belajar coding',
                  'Alasan mengapa kamu harus belajar coding\ndi era sekarang',
                  'https://mywebar.com/p/Project_11_pepox66uf7'),
              buildCard(
                  'gambar/slide4.png',
                  'Kata mereka',
                  'Beberapa orang hebat yang bilang belajar \ncoding itu sangat penting',
                  'https://mywebar.com/p/Project_12_yg9a269zx0'),
              buildCard(
                  'gambar/slide5.png',
                  'Orang sukses',
                  'Orang-orang sukses yang belajar coding\nsiapa aja sih?',
                  'https://mywebar.com/p/Project_13_tecsi6hiiz'),
            ],
          ),
        ),
      ),
    );
  }
}
