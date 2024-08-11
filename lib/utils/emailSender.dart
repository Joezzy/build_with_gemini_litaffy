import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MyMailer {
  static Future<void> sendEmail(
    String recipient,
    String subject,
    String text,
    var yourHtmlTemplate,
  ) async {
    print(recipient);
    String username = 'littafy.app@gmail.com';
    String password = '#Ozil9696';

    final smtpServer = gmail(username, password);
    //Create our Message
    final message = Message()
      ..from = Address(username, 'Flutter Mail')
      ..recipients.add('adekola@gmail.com')
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(const Address('bccAddress@example.com'))
      ..subject = 'Flutter Mailer'
      ..text = 'Auto Mailing with Flutter with Custom Template.';
    yourHtmlTemplate = ''' your html goes here  ''';
    message.html = yourHtmlTemplate;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
