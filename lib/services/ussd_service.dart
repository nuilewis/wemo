import 'package:flutter/material.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class WemoUSSDService {
  requestUSSD(
      {required int number, required int pin, required int amount}) async {
    int subscriptionId =
        -1; //sim 1 or 2 and -1 is for the default phone settings
    String ussdCode = "#123#";
    String mtnMomoCode = "*126*1*1*$number*$amount*Transferred with Wemo*$pin#";
    String orangeCode = "#150#";

    try {
      // String? result = await UssdAdvanced.sendAdvancedUssd(
      //     code: ussdCode, subscriptionId: subscriptionId);
      String? response = await UssdAdvanced.sendAdvancedUssd(
          code: orangeCode, subscriptionId: subscriptionId);

      debugPrint("response from AdvancedUssd is $response");
      // print("success : $result");
    } catch (e) {
      debugPrint("error from sa: $e");
    }
  }

  requestMtnMomo(
      {required String number,
      required String pin,
      required int amount}) async {
    int subscriptionId = -1;
    //sim 1 or 2 and -1 is for the default phone settings

    String mtnMomoCode = "*126*1*1*$number*$amount*ref*$pin#";
    String mtnMomoCodeNoPin = "*126*1*1*$number*$amount*ref*$pin#";
    String orangeMomoCode = "#150*1*1*$number*$amount*$pin";
    try {
      String? response = await UssdAdvanced.multisessionUssd(
          code: mtnMomoCodeNoPin, subscriptionId: subscriptionId);
      debugPrint("response 1 is : $response");

      String? res2 = await UssdAdvanced.sendMessage("1");
      debugPrint("response 2 is $res2");
    } catch (e) {
      debugPrint("multisession USSD error is $e");
      //throw e;
    }
  }
}
