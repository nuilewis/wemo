class Transaction {
  final String name;
  final int number;
  final String network;
  final DateTime time;
  final int amount;
  final int charges;
  final bool transactionType;

  Transaction(
      {required this.name,
      required this.number,
      required this.network,
      required this.time,
      required this.amount,
      required this.charges,
      required this.transactionType});
}

