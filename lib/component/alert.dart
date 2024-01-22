import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';

class AlertSystem {
  static void successAlert(BuildContext context,
      {String text = "data anda berhasil", String? page}) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: text,
        confirmBtnText: "Lanjut",
        barrierDismissible: false,
        onConfirmBtnTap: page != null
            ? () {
                Future.delayed(Duration(seconds: 1));
                Navigator.pushReplacementNamed(context, page);
              }
            : () {});
  }

  static void warningAlert(BuildContext context,
      {String text = "invalid input"}) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text: text,
      confirmBtnText: "Oke",
    );
  }

  static void infoAlert(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: "",
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
                    style:
                        GoogleFonts.roboto(textStyle: TextStyle(fontSize: 15))),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.network_wifi,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Text('Koneksikan jaringan ke internet',
                        softWrap: true,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(fontSize: 15))),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.camera_enhance,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Text('Izinkan akses kamera pada\nbrowser kamu',
                        softWrap: true,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(fontSize: 15))),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
