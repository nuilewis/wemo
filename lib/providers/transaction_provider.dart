import 'package:flutter/cupertino.dart';
import 'package:wemo/services/shared_prefs/shared_prefs_methods.dart';

import '../models/transaction_model.dart';

class TransactionData extends ChangeNotifier {
  List<Transaction> transactionsList = [];

  String? transactionResult;

  void getSavedTransactions() {
    initSharedPrefs();

    List<Transaction> savedTransactionList = savedTransactionsList;
    if (savedTransactionList.isNotEmpty) {
      transactionsList = savedTransactionsList;
    }
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    //transactionsList.add(transaction);
    //also add save to shared prefs

    addToTransactionSavedList(transactionToSave: transaction);
    notifyListeners();
  }

  void removeTransaction(index) {
    transactionsList.removeAt(index);
    //Also remove from transaction List
    removeTransactionFromSavedList(index);
    notifyListeners();
  }

  void setTransactionResult(String? result) {
    transactionResult = result;

    notifyListeners();
  }
}
