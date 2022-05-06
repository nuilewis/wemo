import 'package:flutter/cupertino.dart';
import 'package:wemo/models/info_model.dart';

class MomoNumberData extends ChangeNotifier {
  List<MomoNumber> momoNumberList = [];

  void addMomoNUmber({required String name, required String number}) {
    int numToInt = double.tryParse(number)!.toInt();

    momoNumberList.add(MomoNumber(name: name, number: numToInt));
    notifyListeners();
  }

  void deleteMomoNUmber(int index) {
    momoNumberList.removeAt(index);
    notifyListeners();
  }
}
