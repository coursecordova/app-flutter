// import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_cordova/page/navigasion_page/my_learning_page.dart';
import 'package:flutter_application_cordova/page/navigasion_page/presentation_page.dart';
import 'package:flutter_application_cordova/page/navigasion_page/home_page.dart';
// import 'package:flutter_application_cordova/pilih kelas.dart';
import 'package:flutter_application_cordova/page/navigasion_page/account_page.dart';

// ignore: must_be_immutable
class NavigasiBar extends StatefulWidget {
  NavigasiBar({super.key});

  bool isHome = true;

  void hideNavbar() {
    isHome = false;
  }

  @override
  State<NavigasiBar> createState() => _NavigasiBarState();
}

class _NavigasiBarState extends State<NavigasiBar> {
  int index = 0;
  bool danta = true;
  final screen = [
    HomePage(),
    MyLearningPage(),
    PresentationPage(),
    AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    // menghapus meterial app
    return WillPopScope(
      onWillPop: () async {
        if (index == 0) {
          SystemNavigator.pop();
        }
        if (index != 0) {
          setState(() {
            index = 0;
          });
        }
        return false;
      },
      child: Scaffold(
        body: screen[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              elevation: 10,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              height: 57,
              surfaceTintColor: Color(0xFFEF2D74),
              indicatorColor: Color.fromARGB(255, 252, 222, 236),
              backgroundColor: Colors.white,
              labelTextStyle: MaterialStateProperty.all(TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey))),
          child: Visibility(
            visible: widget.isHome,
            child: NavigationBar(
                selectedIndex: index,
                onDestinationSelected: ((index) => setState(() {
                      this.index = index;
                    })),
                destinations: [
                  NavigationDestination(
                      icon: Icon(
                        Icons.home,
                        color: (index == 0) ? Color(0xFFEF2D74) : Colors.grey,
                      ),
                      label: 'Home'),
                  NavigationDestination(
                      icon: Icon(Icons.school,
                          color:
                              (index == 1) ? Color(0xFFEF2D74) : Colors.grey),
                      label: 'My-learning'),
                  NavigationDestination(
                      icon: Icon(Icons.scanner,
                          color:
                              (index == 2) ? Color(0xFFEF2D74) : Colors.grey),
                      label: 'Presentasi'),
                  NavigationDestination(
                      icon: Icon(Icons.info,
                          color:
                              (index == 3) ? Color(0xFFEF2D74) : Colors.grey),
                      label: 'Info'),
                ]),
          ),
        ),
      ),
    );
  }
}
