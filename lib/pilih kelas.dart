import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_application_cordova/shimmer.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_cordova/form daftar.dart';
import 'package:flutter_application_cordova/error_handler.dart';

class pilihKelas extends StatefulWidget {
  const pilihKelas({super.key});

  @override
  State<pilihKelas> createState() => _pilihKelasState();
}

class _pilihKelasState extends State<pilihKelas> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool isError = false;
  String link = '';
  bool showAppBar = true;
  bool pageform = false;
  String title = '';
  bool showIcon = false;
  bool titiletDitengah = false;
  bool warnaPutih = false;
  bool warnaTeksAppbar_hitam = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String url =
      'https://wa.me/${6282124308812}?text=Hai Cordovacourse, mau tanya-tanya soal kursus dong';
  _launchURL() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void changeTitle() {
    showIcon = false;
    titiletDitengah = true;
    warnaPutih = false;
    warnaTeksAppbar_hitam = false;
    if (link == 'https://cordovacourse.com/form-regristasi-app/') {
      title = 'Form Regristrasi';
      showIcon = false;
    } else if (link == 'https://cordovacourse.com/kelas-basic-app/') {
      title = 'Bahasa Pemograman';
    } else if (link == 'https://cordovacourse.com/kelas-scratch-app/') {
      title = 'Scratch Prorgamming';
    } else if (link == 'https://cordovacourse.com/kelas-mobile-development-app/') {
      title = 'Mobile Development';
    } else if (link == 'https://cordovacourse.com/kelas-front-end-app/') {
      title = 'Frontend Development';
    } else if (link == 'https://cordovacourse.com/kelas-back-end-app/') {
      title = 'Backend Development';
    } else if (link == 'https://cordovacourse.com/kelas-front-end-hp-app/') {
      title = 'Frontend Develoment (Hp)';
    }
    else if (link == 'https://cordovacourse.com/kelas-app/') {
      title = 'Cordovacourse';
      titiletDitengah = false;
    }
    else{
      title = '';
    }
  }

  void pageForm() {
    if (link == 'https://cordovacourse.com/form-regristasi-app/') {
      pageform = true;
    } else {
      pageform = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    pageForm();
    changeTitle();

    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: titiletDitengah,
          title: Text(
            '$title',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 17,
                    color:
                        (warnaTeksAppbar_hitam) ? Colors.black : Colors.white)),
          ),
          backgroundColor:
              (warnaPutih) ? Colors.white : Color.fromARGB(255, 192, 34, 89),
        ),
        body: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://cordovacourse.com/kelas-app/',
              onWebViewCreated: (WebViewController controller) {
                _controller = controller;
              },
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
              onProgress: (progress) {
                setState(() {
                  isLoading = true;
                });
              },
              onPageStarted: ((url) {
                setState(() {
                  link = url;
                });
              }),
              onWebResourceError: ((error) {
                setState(() {
                  isError = true;
                  isLoading = false;
                });
              }),
            ),
            pageform ? formDaftar() : Stack(),
            isLoading ? LoadingListPage() : Stack(),
            isError ? erroHandler() : Stack(),
          ],
        ),
      ),
    );
  }
}

