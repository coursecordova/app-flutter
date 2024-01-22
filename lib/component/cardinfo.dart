import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/navigation%20bar.dart';
import 'package:flutter_application_cordova/page/user_info_page.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class CardInfo extends StatelessWidget {
  final IconData iconName;
  final String cardText;
  final String url;
  final bool isExternal;

  NavigasiBar hide = NavigasiBar();

  _launchURL() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(
      uri,
    )) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'system failed';
    }
  }

  CardInfo(
      {required this.iconName,
      required this.cardText,
      required this.url,
      required this.isExternal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (url != '') {
          if (isExternal) {
            _launchURL();
          } else {
            hide.hideNavbar();
            print(hide.toString());
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => UserInformation()));
          }
        }
      },
      child: Container(
        height: 70,
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Card(
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                iconName,
                color: Color(0xFFEF2D74),
              ),
              SizedBox(
                width: 10,
              ),
              Text(cardText),
              Spacer(),
              Icon(Icons.navigate_next)
            ],
          ),
        ),
      ),
    );
  }
}
