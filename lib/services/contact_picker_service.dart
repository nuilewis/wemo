import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class ContactPickerService {
  Future<Map<String, String?>> pickContact() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    String? number = contact.phoneNumber?.number;
    String? name = contact.fullName;
    Map<String, String?> fullContact = {};

    ///Remove uneccasry srting from the number
    ///
    String optimizedNum = number!.replaceAll(RegExp("[^0-9]"), "");

    ///Check if number is longer than 9 digits, if so, cut it down

    if (optimizedNum.length > 9) {
      String shortenedOptimizedNumber =
          optimizedNum.substring(optimizedNum.length - 9);
      fullContact = {
        "number": shortenedOptimizedNumber,
        "name": name,
      };
    } else {
      ///Arranging the picked name and number into a Map
      fullContact = {
        "number": optimizedNum,
        "name": name,
      };
    }

    return fullContact;
  }
}
