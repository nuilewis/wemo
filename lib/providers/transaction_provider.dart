import 'package:flutter/cupertino.dart';
import 'package:wemo/services/shared_prefs/shared_prefs_methods.dart';

import '../models/transaction_model.dart';

class TransactionData extends ChangeNotifier {
  List<Transaction> transactionsList = [];

  String? transactionResult;

  void getSavedTransactions() {
    SharedPrefsService().initSharedPrefs();

    List<Transaction> savedTransactionList =
        SharedPrefsService().savedTransactionsList;
    if (savedTransactionList.isNotEmpty) {
      transactionsList = SharedPrefsService().savedTransactionsList;
    }
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    transactionsList.add(transaction);
    //also add save to shared prefs
    SharedPrefsService()
        .addToTransactionSavedList(transactionToSave: transaction);
    notifyListeners();
  }

  void removeTransaction(index) {
    transactionsList.removeAt(index);
    //Also remove from transaction List
    SharedPrefsService().removeTransactionFromSavedList(index);
    notifyListeners();
  }

  void setTransactionResult(String? result) {
    transactionResult = result;

    notifyListeners();
  }
}
