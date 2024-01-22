import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/utils/data.dart';
import 'package:flutter_application_cordova/page/auth_page.dart';
import 'package:flutter_application_cordova/utils/google_service.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Map<String, dynamic> userData = Userpref.getUserData();

  // Logout
  logout() async {
    // logout sharedPreferenced
    await Userpref.deleteData("userdata");
    await Userpref.setIsLogin(false);

    GoogleService googleService = GoogleService();
    await googleService.googleLogout();

    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => AuthPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(25, 50, 25, 25),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink, // Warna padding
                      ),
                      child: ClipOval(
                        child: Image(
                          image: AssetImage("gambar/default_profile.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userData['username'] ?? "johny",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500))),
                      Text("Reguler member",
                          style: GoogleFonts.roboto(
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.grey))),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 40,
                    width: 40,
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Color(0xFFEF2D74),
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.52,
              margin: EdgeInsets.only(top: 20),
              child: Card(
                  child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Color(0xFFEF2D74),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              userData['email'] ?? "johny@gmail.com",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: Color(0xFFEF2D74),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              userData['username'] ?? "johny",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.school,
                          color: Color(0xFFEF2D74),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Asal sekolah",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              userData['sekolah'] ?? "belum diisi",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Color(0xFFEF2D74),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No telp",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              userData['noHp'] ?? "belum diisi",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.contact_support,
                          color: Color(0xFFEF2D74),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pusat bantuan",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "082190908899",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () async {
                  await logout();
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEF2D74),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Text(
                    "Version 1.1.0",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.grey)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
