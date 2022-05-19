import 'package:flutter/cupertino.dart';
import 'package:wemo/models/momo_num_model.dart';
import 'package:wemo/services/shared_prefs/shared_prefs_methods.dart';
import 'package:wemo/services/transaction_service.dart';

class MomoNumberData extends ChangeNotifier {
  List<MomoNumber> momoNumberList = [];

  ///Get saved numbers and assign to momo Numbers

  void getSavedMomoNUmber() async {
    SharedPrefsService().initSharedPrefs();

    List<MomoNumber> savedMomoNumber = SharedPrefsService().savedNumbersList;

    if (savedMomoNumber.isNotEmpty) {
      momoNumberList = SharedPrefsService().savedNumbersList;
    }
    notifyListeners();
  }

  void addMomoNumber({required String name, required String number}) {
    MomoNumber momoNumberToAddAndSave = MomoNumber(
        name: name,
        number: number,
        network: TransactionService.determinNetwork(number));
    momoNumberList.add(momoNumberToAddAndSave);

    //also add to saved momo numbers
    SharedPrefsService()
        .addToMomoSavedList(numberToSave: momoNumberToAddAndSave);

    debugPrint("momoList is $momoNumberList");
    notifyListeners();
  }

  void deleteMomoNUmber(int index) {
    momoNumberList.removeAt(index);

    //also delete momoNumber from saved List
    SharedPrefsService().removeMomoNumFromSavedList(index);
    notifyListeners();
  }
}
