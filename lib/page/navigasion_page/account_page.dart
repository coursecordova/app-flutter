import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/component/cardinfo.dart';
import 'package:flutter_application_cordova/utils/data.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Map<String, dynamic> userData = Userpref.getUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "My Account",
          style: GoogleFonts.roboto(
              textStyle: TextStyle(color: Colors.white, fontSize: 17)),
        ),
        backgroundColor: Color(0xFFEF2D74),
      ),
      body: Column(
        children: [
          // photo profil
          Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(2),
                child: ClipOval(
                  child: Image(
                    image: AssetImage("gambar/default_profile.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 125,
                height: 125,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.pink)),
          ),
          Text(userData['username'] ?? 'johny',
              style: GoogleFonts.roboto(
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
          Text(userData['email'] ?? "jonny@gmail.com",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(fontSize: 16, color: Colors.grey))),
          // card info
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                CardInfo(
                  iconName: Icons.account_circle,
                  cardText: "Akun saya",
                  url: '/user_information',
                  isExternal: false,
                ),
                CardInfo(
                  iconName: Icons.question_answer,
                  cardText: "FAQ",
                  url: 'https://cordovacourse.com/faq-app/',
                  isExternal: true,
                ),
                CardInfo(
                  iconName: Icons.book,
                  cardText: "Syarat & Ketentuan",
                  url: 'https://cordovacourse.com/syarat-ketentuan-app/',
                  isExternal: true,
                ),
                CardInfo(
                  iconName: Icons.person,
                  cardText: "Tentang Kami",
                  url: 'https://cordovacourse.com/tentang-kami-app/',
                  isExternal: true,
                ),
                CardInfo(
                  iconName: Icons.perm_phone_msg,
                  cardText: "Hubungi kami",
                  url:
                      'https://wa.me/${6282124308812} ?text=Halo, Cordovacourse',
                  isExternal: true,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
