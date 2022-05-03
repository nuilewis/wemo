class Transaction {
  final String name;
 final  int number;
  final String network;
 final  DateTime time;


  Transaction({required this.name, required this.number, required this.network, required this.time});

}

enum TransactionType{
  transactionType.send;
  transactionType.received;
}