import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> readEmailTemplate() async {
  return await rootBundle.loadString('template/email.html');
}

Future emailSender(String emailUsers, String resetToken) async {
  String username = 'tiktokcordova9@gmail.com';
  String password = 'fvsllpmmdjbicudm';

  String emailTemplate = await readEmailTemplate();
  emailTemplate = emailTemplate.replaceAll('{token}', resetToken);

  final smtpServer = gmail(username, password);
  final message = Message()
    ..from = Address(username, 'indra')
    ..recipients.add(emailUsers)
    ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Cordova course reset password'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = emailTemplate;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
