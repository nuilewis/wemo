import 'package:url_launcher/url_launcher.dart';

class UrlService{

   Future<void > navToPrivacyPolicy(Uri url) async {
   if(!await launchUrl(url, mode: LaunchMode.externalApplication ) ) {
    throw "Could Not Launch url";
   }
  }
}