
import 'package:url_launcher/url_launcher.dart';

launchURL(String string) async {
  if (await canLaunchUrl(Uri.parse(string))) {
    await launchUrl(Uri.parse(string));
  } else {
    throw 'Çalıştırılamadı';
  }
}