import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/page/course_information_page.dart';
import 'package:flutter_application_cordova/page/user_info_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_cordova/utils/course_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Cordovacourse',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(fontSize: 17, color: Colors.white)),
        ),
        backgroundColor: Color(0xFFEF2D74),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // reverse: true,
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.29,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage("gambar/home_hero.png"),
              fit: BoxFit.cover,
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            elevation: 5,
            shadowColor: Colors.black, // shadow color
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await launchUrl(
                        Uri.parse('https://cordovacourse.com/kelas-gratis/'),
                        mode: LaunchMode.externalApplication);
                  },
                  child: Container(
                    child: ClipRRect(
                      child: Image(
                          image: AssetImage('gambar/home_secondhero.png')),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 5, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Buat kamu yang tidak punya laptop",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Kelas gratis buat kamu yang mau belajar buat website dengan hp aja. Yuk, buruan daftar!",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 25), child: GridCard())
        ]),
      ),
    );
  }
}

class GridCard extends StatefulWidget {
  const GridCard({super.key});

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  List<Map<String, dynamic>> courseList = courseData.values.toList();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisExtent: 320,
            mainAxisSpacing: 20),
        itemCount: courseData.length,
        itemBuilder: ((context, index) {
          final course = courseList[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) =>
                      CourseInformationPage(courseId: (index + 1).toString())));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Warna bayangan
                    spreadRadius: 2, // Penyebaran bayangan
                    blurRadius: 1, // Radius blur bayangan
                    offset: Offset(2, 2), // Posisi bayangan
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    child: ClipRRect(
                        child: Image(
                          image: NetworkImage(course['image']),
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          course['name'],
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '5',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFEF2D74)),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Row(
                              children: List<Widget>.generate(
                                5,
                                (index) => Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Color(0xFFEF2D74),
                              size: 16,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              course['level'],
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.loyalty,
                              color: Color(0xFFEF2D74),
                              size: 16,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              course['harga'],
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
