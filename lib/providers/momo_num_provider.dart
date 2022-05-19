import 'package:flutter/cupertino.dart';
import 'package:wemo/models/momo_num_model.dart';
import 'package:wemo/services/transaction_service.dart';

class MomoNumberData extends ChangeNotifier {
  List<MomoNumber> momoNumberList = [];

  void addMomoNUmber({required String name, required String number}) {
    momoNumberList.add(MomoNumber(
        name: name,
        number: number,
        network: TransactionService.determinNetwork(number)));

    print("momoList is $momoNumberList");
    notifyListeners();
  }

  void deleteMomoNUmber(int index) {
    momoNumberList.removeAt(index);
    notifyListeners();
  }
}
