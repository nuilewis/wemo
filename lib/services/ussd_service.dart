import 'package:flutter/material.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class WemoUSSDService {
  requestUSSD(String? number, String? pin, String? amount) async {
    int subscriptionId =
        -1; //sim 1 or 2 and -1 is for the default phone settings
    String ussdCode = "#123#";
    String mtmMomoCode = "*126*1*$number*$amount*$pin#";

    try {
      // String? result = await UssdAdvanced.sendAdvancedUssd(
      //     code: ussdCode, subscriptionId: subscriptionId);
 UssdAdvanced.sendUssd(
          code: ussdCode, subscriptionId: subscriptionId);
      //print("success : $result");
    } catch (e) {
      debugPrint("error: $e");
    }
  }
}
