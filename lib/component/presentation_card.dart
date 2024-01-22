import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentationCard extends StatelessWidget {
  // const PresentationCard({super.key});

  final String gambar;
  final String judul;
  final String desc;
  final String tautan;

  const PresentationCard({
    required this.gambar,
    required this.judul,
    required this.desc,
    required this.tautan,
  });

  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    style:
                        GoogleFonts.roboto(textStyle: TextStyle(fontSize: 10)),
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
                        _launchURL(tautan);
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
}
