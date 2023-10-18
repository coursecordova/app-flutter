// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/pilih kelas.dart';
import 'package:flutter_application_cordova/my_learning.dart';
import 'package:flutter_application_cordova/presentasi.dart';
import 'package:flutter_application_cordova/info.dart';

class NavigasiBar extends StatefulWidget {
  const NavigasiBar({super.key});

  @override
  State<NavigasiBar> createState() => _NavigasiBarState();
}

class _NavigasiBarState extends State<NavigasiBar> {
  int index = 0;
  bool danta = true;
  final screen = [
    pilihKelas(),
    myLearning(),
    Presetasi(),
    info()
  ];

  @override     
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 10,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow ,
          height: 57,
          surfaceTintColor: Color.fromARGB(255, 192, 34, 89),
          indicatorColor: Color.fromARGB(255, 252, 222, 236),
          backgroundColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))
        ),
        child: NavigationBar(    
          selectedIndex: index,
          onDestinationSelected: ((index) => setState(() {
            this.index = index;
          })),
          destinations: [
          NavigationDestination(icon: Icon(Icons.home, color:  (index == 0) ?  Color.fromARGB(255, 192, 34, 89) : Colors.grey, ),label: 'Home'),
          NavigationDestination(icon: Icon(Icons.school, color:  (index == 1) ?  Color.fromARGB(255, 192, 34, 89) : Colors.grey), label: 'My-learning'),
          NavigationDestination(icon: Icon(Icons.scanner, color:  (index == 2) ?  Color.fromARGB(255, 192, 34, 89) : Colors.grey), label: 'Presentasi'),
          NavigationDestination(icon: Icon(Icons.info, color:  (index == 3) ?  Color.fromARGB(255, 192, 34, 89) : Colors.grey), label: 'Info'),        ]),
      ),
    );
  }
}
