import 'package:flutter/cupertino.dart';

import '../models/transaction_model.dart';

class TransactionData extends ChangeNotifier {
  List<Transaction> transactionsList = [];

  void addTransaction(Transaction transaction) {
    transactionsList.add(transaction);
    notifyListeners();
  }

  void removeTransaction(index) {
    transactionsList.removeAt(index);
    notifyListeners();
  }
}
