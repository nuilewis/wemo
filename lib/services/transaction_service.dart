import 'package:wemo/enums/wemo_enums.dart';

class TransactionService {
  static NetworkType determinNetwork(String phoneNumber) {
    NetworkType networkType = NetworkType.mtn;

    ///takes the phone number and returns the network
    ///but befor that, first remove any 237 in the number before making checking

    ///Removing '237's
    ///

    if (phoneNumber.startsWith("237")) {
      phoneNumber = phoneNumber.substring(3);
    } else if (phoneNumber.startsWith("+237")) {
      phoneNumber = phoneNumber.substring(4);
    }

    if (phoneNumber.startsWith("67") ||
        phoneNumber.startsWith("68") ||
        phoneNumber.startsWith("65")) {
      networkType = NetworkType.mtn;
    } else if (phoneNumber.startsWith("69") || phoneNumber.startsWith("65")) {
      networkType = NetworkType.orange;
    }

    return networkType;
  }

  static int calculateCharges(int amount) {
    int amountWithCharges = 0;

    ///calculate 2% of amount

    int chargesToAdd = ((amount / 100) * 2).toInt();

    if (chargesToAdd < 50) {
      chargesToAdd = 50;
    } else if (chargesToAdd > 3500) {
      chargesToAdd = 3500;
    }

    ///Momo has a min charge of 50 and a max charge of 3500 for transactions
    ///of upto 500,000 fcfa. And widthdrawal charges are 2% of the amount to be sent

    ///add calculated charges to the amount

    amountWithCharges = amount + chargesToAdd;

    return amountWithCharges;
  }
}
