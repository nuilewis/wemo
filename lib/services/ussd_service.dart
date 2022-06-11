import 'package:flutter/material.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class WemoUSSDService {
  requestUSSD(
      {required String number, String? ref, required int amount}) async {
    int subscriptionId =
        -1; //sim 1 or 2 and -1 is for the default phone setting

    // String mtnMomoCode =
    //     "*126*1*1*$number*$amount* ${ref??""} | Transferred with Wemo#";
   // String mtnShortCodewithRef =
   //     "*126*9*$number*$amount*${ref ?? ""} | Transferred with Wemo#";
    String mtnShortCode = "*126*9*$number*$amount#";
    //String orangeCode = "#150*1*1*$number*$amount#";

    try {
      // String? result = await UssdAdvanced.sendAdvancedUssd(
      //     code: ussdCode, subscriptionId: subscriptionId);
      UssdAdvanced.sendUssd(code: mtnShortCode, subscriptionId: subscriptionId);
    } catch (e) {
      debugPrint("error from sa: $e");
    }
  }

  requestMultiSessionUSSD(
    BuildContext context, {
    required String number,
    required String pin,
    required int amount,
  }) async {
    int subscriptionId = -1;
    //sim 1 or 2 and -1 is for the default phone settings

    // String mtnMomoCode = "*126*1*1*$number*$amount*Transferred with Wemo*$pin#";
    String mtnMomoCodeNoPin = "*126*1*1*$number*$amount*Transferred with Wemo#";
    // String orangeMomoCode = "#150*1*1*$number*$amount*$pin";
    // String orangeMomoCodeNoPin = "#150*1*1*$number*$amount#";
    try {
      String? response = await UssdAdvanced.multisessionUssd(
          code: mtnMomoCodeNoPin, subscriptionId: subscriptionId);
      debugPrint("response 1 is : $response");

      //Provider.of<TransactionData>(context).setTransactionResult(response);
      // String? res2 = await UssdAdvanced.sendMessage("1");
      // debugPrint("response 2 is $res2");
    } catch (e) {
      debugPrint("multisession USSD error is $e");
      //throw e;
    }
  }
}
