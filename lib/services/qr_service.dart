
class QrService {
  ///INterpolate name and number into a single string to feed to tthe GR generator

  String joinNameNUmber(int number, String name) {
    String joinedString = "";
    String numToString = number.toString();

    ///check if number includes country code, ie +237

    if (numToString.startsWith("237")) {
//remove country code and join the name;
      joinedString = numToString.substring(3) + name;
    } else if (numToString.startsWith("+237")) {
      joinedString = numToString.substring(4) + name;
    } else if (numToString.startsWith("6")) {
      joinedString = numToString + name;
    }

    return joinedString;
  }
}
