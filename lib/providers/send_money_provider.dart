

import 'package:flutter/cupertino.dart';
import 'package:wemo/models/send_money_model.dart';

class SendMoneyData extends ChangeNotifier{



SendMoney? moneyToSend;


void  sendMoneyToPerson( {required int amount, required String pin, required String name, required String number}){



  moneyToSend = SendMoney(amount: amount, pin: pin, name: name, number:  number);

  print("details of person to send money succesfully added to provider");
  print(name);
  print(number);
  print(amount);
  print(pin);
 
  notifyListeners();
}





}