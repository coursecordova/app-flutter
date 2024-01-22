import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/page/learning_page/learning_page.dart';
import 'package:flutter_application_cordova/utils/course_data.dart';
import 'package:flutter_application_cordova/utils/course_util.dart';
import 'package:flutter_application_cordova/utils/data.dart';
import 'package:flutter_application_cordova/utils/dummy_user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLearningPage extends StatefulWidget {
  const MyLearningPage({super.key});

  @override
  State<MyLearningPage> createState() => _MyLearningPageState();
}

class _MyLearningPageState extends State<MyLearningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'My-Learning',
            style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 17)),
          ),
          backgroundColor: Color(0xFFEF2D74),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [ClassCard()],
          ),
        ));
  }
}

class getUser {
  static Map<String, dynamic>? loginUser(String email) {
    Map<String, dynamic>? user = userData.values.firstWhere(
      (value) => value['email'] == email,
      orElse: () => null,
    );

    if (user != null) {
      debugPrint("Data ditemukan");
      debugPrint(user.toString());
    } else {
      debugPrint("Data tidak ditemukan");
    }

    return user;
  }
}

class ClassCard extends StatefulWidget {
  const ClassCard({super.key});

  @override
  State<ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  // user login
  Map<String, dynamic> userData = Userpref.getUserData();

  // Map<String, dynamic>? user =
  //     getUser.loginUser('rendimana1997@gmail.com') ?? null;

  @override
  Widget build(BuildContext context) {
    // get data from user database
    // Map<String, dynamic>? userClass = user?['class'];

    return StreamBuilder(
        stream: getCourseByEmail(userData['email']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: SpinKitRing(
                color: Color.fromARGB(253, 215, 5, 124),
                size: 75.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          } else {
            Map<String, dynamic> courseValue = snapshot.data ?? {};
            // List<dynamic> courses = courseValue['course'] ?? [];

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: courseValue.length,
              itemBuilder: ((context, index) {
                // value for course Id
                String course_id =
                    courseData[courseValue['$index']]?['course_id'];

                // value for card color
                int? colorValue = int.tryParse(courseData[courseValue['$index']]
                        ?['color'] ??
                    '0xFFF3A01C');

                // Return card
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: ((context) => LearningPage(
                              courseId: course_id,
                            ))));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3FFFFFFF),
                                    blurRadius: 100,
                                    offset: Offset(-5, -5),
                                    spreadRadius: 10,
                                  ),
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 100,
                                    offset: Offset(5, 5),
                                    spreadRadius: 5,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Stack(children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      decoration: ShapeDecoration(
                                        color: Color(colorValue!),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 24,
                                      left: 16,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Text(
                                          courseData[courseValue['$index']]
                                                  ?['name'] ??
                                              "NULL",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          )),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 16,
                                      left: 16,
                                      child: Text(
                                        "15 Murid bergabung",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        )),
                                      ),
                                    )
                                  ]),
                                  Container(
                                    margin: EdgeInsets.only(top: 16, left: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.alarm,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text("12 Minggu"),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Icon(
                                          Icons.videocam,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text("16 Video"),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Icon(
                                          Icons.work,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text("12 Tugas")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ])),
                );
              }),
            );
          }
        });
  }
}
