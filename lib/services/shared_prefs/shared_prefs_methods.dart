import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemo/models/momo_num_model.dart';
import 'package:wemo/models/transaction_model.dart';

class SharedPrefsService {
  ///initialise Shared prefs
  ///
  List<MomoNumber> savedNumbersList = <MomoNumber>[];
  List<Transaction> savedTransactionsList = <Transaction>[];

  late final SharedPreferences wemoSharedPrefs;

  void initSharedPrefs() async {
    wemoSharedPrefs = await SharedPreferences.getInstance();
    _loadMomoSPData();
    _loadTransactionSPData();
  }

  ///Load SP Data

  void _loadMomoSPData() async {
    List<String>? momoSPList = wemoSharedPrefs.getStringList("momoNumList");

    savedNumbersList = momoSPList!
        .map((savedNumbers) => MomoNumber.fromMap(json.decode(savedNumbers)))
        .toList();
  }

  void _loadTransactionSPData() async {
    List<String>? transactionSPList =
        wemoSharedPrefs.getStringList("transactionList");
    savedTransactionsList = transactionSPList!
        .map((savedTransaction) =>
            Transaction.fromMap(json.decode(savedTransaction)))
        .toList();
  }

  ///Save SP Data

  void _saveMomoSPData() async {
    List<String> momoSPList = savedNumbersList
        .map((savedNumbers) => json.encode(savedNumbers.toMap()))
        .toList();
    //Save the list
    wemoSharedPrefs.setStringList("momoNumList", momoSPList);
    debugPrint("saved list of saved momo numbers are $momoSPList");
  }

  void _saveTransactionSPData() async {
    List<String> transactionSPList = savedTransactionsList
        .map((savedTransactions) => json.encode(savedTransactions.toMap()))
        .toList();
    //Saving the List
    wemoSharedPrefs.setStringList("transactionList", transactionSPList);
    debugPrint("saved list of saved transactions are $transactionSPList");
  }

  ///Add new Data to the List to Save

  void addToMomoSavedList({required MomoNumber numberToSave}) {
    //Add to the list of saved numbers
    savedNumbersList.add(numberToSave);

    //Now save the list
    _saveMomoSPData();
  }

  void addToTransactionSavedList({required Transaction transactionToSave}) {
    //Add to the list of saved transactions
    savedTransactionsList.add(transactionToSave);
    //Save the transaction list

    _saveTransactionSPData();
  }

  ///Remove Data from the savedList

  void removeMomoNumFromSavedList(int index) {
    // savedNumbersList
    //     .removeWhere((numberToRemove) => numberToRemove.number == number);

    savedNumbersList.removeAt(index);

    _saveMomoSPData();
  }

  void removeTransactionFromSavedList(int index) {
    ///Remove transactions at a particular index instead of comparing names or numbers or amount
    ///because you can send the same amount to the same person multiple times, so I'll just remove by index

    savedTransactionsList.removeAt(index);
    _saveTransactionSPData();
  }
}
