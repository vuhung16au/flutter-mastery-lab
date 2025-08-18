import 'package:url_launcher/url_launcher.dart';

class CommunicationService {
  static Future<void> sendEmail({
    required String to,
    String? subject,
    String? body,
  }) async {
    final Map<String, String> params = {
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
    };
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: to,
      query: params.isEmpty ? null : Uri(queryParameters: params).query,
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch email app';
    }
  }

  static Future<void> sendSMS({
    required String phoneNumber,
    required String message,
  }) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      query: Uri(queryParameters: {'body': message}).query,
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(
        smsUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch SMS app';
    }
  }

  static Future<void> makeCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(
        callUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch phone app';
    }
  }
}
