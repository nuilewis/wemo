import 'package:flutter/cupertino.dart';
import 'package:wemo/models/momo_num_model.dart';
import 'package:wemo/services/transaction_service.dart';

class MomoNumberData extends ChangeNotifier {
  List<MomoNumber> momoNumberList = [];

  void addMomoNUmber({required String name, required String number}) {
    int numToInt = double.tryParse(number)!.toInt();

    momoNumberList.add(MomoNumber(
        name: name,
        number: numToInt,
        network: TransactionService.determinNetwork(numToInt)));
    notifyListeners();
  }

  void deleteMomoNUmber(int index) {
    momoNumberList.removeAt(index);
    notifyListeners();
  }
}
