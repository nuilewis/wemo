import 'package:flutter/foundation.dart';

class QrService {
  ///Interpolate name and number into a single string to feed to tthe GR generator

  ///INterpolating the Name and nUmber Strings

  String joinNameNUmber({required int number, required String name}) {
    String numToString = number.toString();

    String joinedString = numToString + name;
    debugPrint("joined string is $joinedString");
    return joinedString;
  }

  splitNameNumber({required String joinedString}) {}
}
