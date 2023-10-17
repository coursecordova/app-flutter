import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_application_cordova/shimmer.dart';
import 'package:flutter_application_cordova/error_handler.dart';

class myLearning extends StatefulWidget {
  const myLearning({super.key});

  @override
  State<myLearning> createState() => _myLearningState();
}

class _myLearningState extends State<myLearning> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool isError = false;
  String link = '';
  bool showAppBar = true;
  bool pageform = false;
  @override
  Widget build(BuildContext context) {
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
          centerTitle: true,
          title: Text(
            'My-Learning',
            style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 17)),
          ),
          backgroundColor: Color.fromARGB(255, 192, 34, 89),
        ),
        body: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://cordovacourse.com/my-learning/',
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
            isLoading ? LoadingListPage() : Stack(),
            isError ? erroHandler() : Stack(),
          ],
        ),
      ),
    );
  }
}
