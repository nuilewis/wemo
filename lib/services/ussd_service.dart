import 'package:flutter/material.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class WemoUSSDService {
  requestUSSD({required int number, required int pin, required int amount}) async {
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

        //  print("response from mtn is $response");
      // print("success : $result");
    } catch (e) {
      debugPrint("error from sa: $e");
    }








  }


  requestMtnMomo({required String number, required String pin, required int amount})async{


       int subscriptionId =
        -1; //sim 1 or 2 and -1 is for the default phone settings

    String mtnMomoCode = "*126*1*1*$number*$amount*ref*$pin#";
       String mtnMomoCodeNoPin = "*126*1*1*$number*$amount*ref*$pin#";
       String orangeMomoCode = "#150*1*1*$number*$amount*$pin";
  // List<dynamic> mtnCodeSplit = ["*126#", 1];
    // List<dynamic> mtnCodeSplit = ["#150#", 1];
       try{
         String? response = await UssdAdvanced.multisessionUssd(code: mtnMomoCodeNoPin, subscriptionId: -1);
         print("response 1 is : $response");
         

         String? res2= await UssdAdvanced.sendMessage("1");
         print("resoinse 2 is $res2");
       }
       catch(e){
         print("error is blah $e");
        //throw e;
       }



  }
}
