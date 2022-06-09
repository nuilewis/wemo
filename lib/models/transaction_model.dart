class Transaction {
  final String name;
  final String number;
  // final NetworkType network;
  final String network;
  final int time;
  final int amount;
  // final int charges;
  final String transactionType;
  //final TransactionType transactionType;

  Transaction(
      {required this.name,
      required this.number,
      required this.network,
      required this.time,
      required this.amount,
      //   required this.charges,
      required this.transactionType});

  ///Assigning variables values to the map in their corresponding map keys
  Transaction.fromMap(Map map)
      : number = map["number"],
        name = map["name"],
        network = map["network"],
        amount = map["amount"],
        time = map["time"],
        //   charges = map["charges"],
        transactionType = map["transactionType"];

  ///Converting from MomoNumber object to a map
  Map toMap() {
    return {
      "number": number,
      "name": name,
      "network": network,
      "amount": amount,
      "time": time,
      // "charges": charges,
      "transactionType": transactionType,
    };
  }
}
