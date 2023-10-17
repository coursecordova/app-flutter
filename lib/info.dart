import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class info extends StatefulWidget {
  const info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  String url = 'https://cordovacourse.com/syarat-ketentuan-app/';
  int keyCard = 0;
  String title = 'Informasi';
  _launchURL() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri,)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }


  InkWell CardInfo(logo, teks,link) {
    return InkWell(
      splashColor: Colors.red.withAlpha(30),
      onTap: (){
        setState(() {
          url = link;
          _launchURL();
        });
      },
      child: Container(
        height: 70,
        child: Card(
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                logo,
                color: Color.fromARGB(255, 192, 34, 89),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                teks,
                style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '$title',
            style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 17)),
          ),
          backgroundColor: Color.fromARGB(255, 192, 34, 89),
        ),
        body: Column(
          children: [
            CardInfo(Icons.question_answer, 'FAQ', 'https://cordovacourse.com/faq-app/'),
            CardInfo(Icons.book, 'Syarat & Ketentuan','https://cordovacourse.com/syarat-ketentuan-app/'),
            CardInfo(Icons.person, 'Tentang Kami','https://cordovacourse.com/tentang-kami-app/'),
            CardInfo(Icons.whatsapp, 'Hubungi Kami', 'https://wa.me/${6282124308812} ?text=Halo, Cordovacourse'),
          ],
        ),
      ),
    );
  }
}
