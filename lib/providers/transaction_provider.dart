import 'package:flutter/cupertino.dart';
import 'package:wemo/global_components/wemo_snackbar.dart';
import 'package:wemo/services/shared_prefs/shared_prefs_methods.dart';

import '../models/transaction_model.dart';

class TransactionData extends ChangeNotifier {
  List<Transaction> transactionsList = [];

  String? transactionResult;

  void getSavedTransactions() {
    List<Transaction> savedTransList = savedTransactionsList;
    if (savedTransList.isNotEmpty) {
      transactionsList = savedTransactionsList;
    }
  }

  void addTransaction(Transaction transaction) {
    //transactionsList.add(transaction);
    //also add save to shared prefs

    addToTransactionSavedList(transactionToSave: transaction);
    getSavedTransactions();
    notifyListeners();
  }

  void removeTransaction(
    BuildContext context, {
    required int index,
  }) {
    // transactionsList.removeAt(index);
    //Also remove from transaction List
    removeTransactionFromSavedList(index);
    wemoSnackBar(context, message: "Deleted", isSuccess: false);
    notifyListeners();
  }

  void setTransactionResult(String? result) {
    transactionResult = result;

    notifyListeners();
  }
}
