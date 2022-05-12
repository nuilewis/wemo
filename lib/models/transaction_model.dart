import 'package:wemo/enums/wemo_enums.dart';

class Transaction {
  final String name;
  final int number;
  final NetworkType network;
  final DateTime time;
  final int amount;
  final int charges;
  final TransactionType transactionType;

  Transaction(
      {required this.name,
      required this.number,
      required this.network,
      required this.time,
      required this.amount,
      required this.charges,
      required this.transactionType});
}
