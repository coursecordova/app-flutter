import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/navigation%20bar.dart';
import 'package:flutter_application_cordova/page/form_regis_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_application_cordova/utils/course_data.dart';
import 'package:pod_player/pod_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseInformationPage extends StatefulWidget {
  final String courseId;
  const CourseInformationPage({Key? key, required this.courseId})
      : super(key: key);

  @override
  State<CourseInformationPage> createState() => _CourseInformationPageState();
}

class _CourseInformationPageState extends State<CourseInformationPage> {
  late String courseId;
  late PodPlayerController _controller;
  bool isLoved = false;

  @override
  void initState() {
    courseId = widget.courseId;
    final videoId = courseData[courseId]?['url_video'] ??
        'https://www.youtube.com/watch?v=pN7qDnv8Igk';

    _controller =
        PodPlayerController(playVideoFrom: PlayVideoFrom.youtube(videoId))
          ..initialise();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String waktu = courseData[courseId]?['duration'] ?? '4';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Course Details",
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFFEF2D74),
            )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isLoved = !isLoved;
                });
              },
              icon: Icon(
                isLoved ? Icons.favorite : Icons.favorite_border,
                color: isLoved ? Color(0xFFEF2D74) : Colors.black,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          // Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => NavigasiBar()));
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                padding: EdgeInsets.only(bottom: 2),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: PodVideoPlayer(
                      controller: _controller,
                      podProgressBarConfig: const PodProgressBarConfig(
                          playingBarColor: Colors.pink,
                          circleHandlerColor: Colors.pink),
                    )),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseData[courseId]?['name'] ?? "cordova course",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Icon(
                          Icons.schedule,
                          size: 20,
                          color: Color(0xFFEF2D74),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "$waktu bulan",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.school_outlined,
                          size: 20,
                          color: Color(0xFFEF2D74),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          courseData[courseId]?['learningType'] ?? "online",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.sell_outlined,
                          size: 20,
                          color: Color(0xFFEF2D74),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          courseData[courseId]?['harga'] ?? "150k/bulan",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    Container(
                      child: ExpandableText(
                        courseData[courseId]?['description'] ??
                            "No description available",
                        expandText: 'Read more',
                        collapseText: 'show less',
                        maxLines: 3,
                        linkStyle: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFEF2D74),
                                fontWeight: FontWeight.normal,
                                height: 1.5)),
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(200, 49, 48, 77),
                                fontWeight: FontWeight.normal,
                                height: 1.5
                                // letterSpacing: 1.1
                                )),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Materi Pembelajaran',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: ListMaterial(courseId),
                    )
                  ],
                ),
              ),
              CardBenefit(courseId),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Goals',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(courseData[courseId]?['goals'] ??
                        "Mempelajari teknologi baru")
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(courseId),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final String courseId;
  CustomFloatingActionButton(this.courseId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => FormRegisClass(courseId: courseId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width * 0.8, // 80% dari lebar layar
        height: 45.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xFFEF2D74)),
        child: Center(
          child: Text(
            'Daftar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}

class ListMaterial extends StatelessWidget {
  final String courseId;

  ListMaterial(this.courseId);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> learningMaterial =
        courseData[courseId]?['learningMaterial'] ?? {};
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: learningMaterial.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.label_important,
                    color: Color(0xFFEF2D74),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(learningMaterial[index.toString()])
                ],
              )
            ],
          );
        }));
  }
}

class CardBenefit extends StatelessWidget {
  final String courseId;

  CardBenefit(this.courseId);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> courseBenefit = courseData[courseId]?['benefit'] ?? {};
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apa yang kamu dapatkan?',
            style: GoogleFonts.roboto(
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFEF2D74),
                  Colors.purple, // Ganti dengan warna lain jika diinginkan
                ],
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: courseBenefit.length,
              itemBuilder: ((context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.rocket,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        courseBenefit[index.toString()],
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

//Text(learningMaterial[index.toString()]
