import 'package:wemo/enums/wemo_enums.dart';

class TransactionService {
  static NetworkType determinNetwork(int phoneNumber) {
    NetworkType networkType = NetworkType.mtn;

    ///takes the phone number and returns the network
    ///but befor that, first remove any 237 in the number before making checking

    ///Removing '237's
    ///

    String phoneNumToString = phoneNumber.toString();

    if (phoneNumToString.startsWith("237")) {
      phoneNumToString = phoneNumToString.substring(3);
    } else if (phoneNumToString.startsWith("+237")) {
      phoneNumToString = phoneNumToString.substring(4);
    }

    if (phoneNumToString.startsWith("67") ||
        phoneNumToString.startsWith("68") ||
        phoneNumToString.startsWith("65")) {
      networkType = NetworkType.mtn;
    } else if (phoneNumToString.startsWith("69") ||
        phoneNumToString.startsWith("65")) {
      networkType = NetworkType.orange;
    }

    return networkType;
  }

  static int calculateCahrges(int amount) {
    ///Todo: compute charges
    ///
    int amountWithCharges = 0;

    return amountWithCharges;
  }
}
