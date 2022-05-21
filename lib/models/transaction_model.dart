import 'package:wemo/enums/wemo_enums.dart';

class Transaction {
  final String name;
  final String number;
  // final NetworkType network;
  final String network;
  final DateTime time;
  final int amount;
  final int charges;
  //final String transactionType;
  final TransactionType transactionType;

  Transaction(
      {required this.name,
      required this.number,
      required this.network,
      required this.time,
      required this.amount,
      required this.charges,
      required this.transactionType});

  ///Assigning variable values to their corresponding map fields

  Transaction.fromMap(Map map)
      : name = map["name"],
        number = map["number"],
        network = map["network"],
        amount = map["amount"],
        charges = map["charges"],
        time = map["time"],
        transactionType = map["transactionType"];

  ///Converting from Transaction object to a map

  Map toMap() {
    return {
      "name": name,
      "number": number,
      "network": network,
      "amount": amount,
      "charges": charges,
      "transactionType": transactionType,
      "time": time
    };
  }
}
