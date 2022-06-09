import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class ContactPickerService {
  Future<Map<String, String?>> pickContact() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    String? pickedNumber = contact.phoneNumber?.number;
    String? pickedName = contact.fullName;

    ///Arranging the pciked name and number into a Map
    Map<String, String?> fullContact = {
      "number": pickedNumber,
      "name": pickedName
    };
    return fullContact;
  }
}
