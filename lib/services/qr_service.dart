import 'package:flutter/foundation.dart';

class QrService {
  ///Interpolate name and number into a single string to feed to tthe GR generator

  String joinNameNUmber({required int number, required String name}) {
    String numToString = number.toString();

    String joinedString = numToString + name;
    print("joined string is $joinedString");
    return joinedString;
  }

  splitNameNumber({required String joinedString}) {}
}
