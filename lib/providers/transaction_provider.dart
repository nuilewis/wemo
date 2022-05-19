import 'package:flutter/cupertino.dart';

import '../models/transaction_model.dart';

class TransactionData extends ChangeNotifier {
  List<Transaction> transactionsList = [];

  String? transactionResult;

  void addTransaction(Transaction transaction) {
    transactionsList.add(transaction);
    notifyListeners();
  }

  void removeTransaction(index) {
    transactionsList.removeAt(index);
    notifyListeners();
  }

  void setTransactionResult(String? result) {
    transactionResult = result;

    notifyListeners();
  }
}
