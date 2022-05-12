import 'package:flutter/material.dart';

///--------Colours---------///

// const Color kPurple = Color(0xFF531CF7);
// const Color kPurple80 = Color(0xFF7B4FFF);
// const Color kPurple60 = Color(0xFFB298FF);
// const Color kPurple40 = Color(0xFFD3C5FF);
// const Color kPurple20 = Color(0xFFEEE9FF);

const Color kPurple = Color(0xFF531CF7);
const Color kPurple80 = Color(0xB3531CF7);
const Color kPurple60 = Color(0x80531CF7);
const Color kPurple40 = Color(0x4D531CF7);
const Color kPurple20 = Color(0x1A531CF7);

const Color kGreen = Color(0xFF52DBB9);
const Color kFuchsia = Color(0xFFFC4684);
const Color kFuchsia80 = Color(0xFFFF7DA9);

const Color kDark = Color(0xFF353535);
const Color kDark80 = Color(0xB3353535);
const Color kDark60 = Color(0x80353535);
const Color kDark40 = Color(0x4D353535);
const Color kDark20 = Color(0x1A353535);

const double kDefaultPadding = 16.0;
const double kDefaultPadding2x = 32.0;

///----TextStyles----///
const TextStyle kHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 28);
const TextStyle kHeadingLight =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 28);
const TextStyle kBody = TextStyle(fontWeight: FontWeight.normal, fontSize: 14);
const TextStyle kBodyBold =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
const TextStyle kButtonText =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
const TextStyle kFootNote =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 11);

///----AppBar Style----///

AppBarTheme appBarTheme = const AppBarTheme(
  backgroundColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  elevation: 0,
);

///----------Text Form Field styles ---------////

InputDecoration wemoTextFieldDecoration = InputDecoration(
  errorStyle: kBody.copyWith(color: kFuchsia),
  errorBorder: OutlineInputBorder(
    gapPadding: 4,
    borderSide: const BorderSide(color: kFuchsia, width: 1),
    borderRadius: BorderRadius.circular(kDefaultPadding),
  ),
  border: OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(kDefaultPadding),
  ),
  isDense: false,
  filled: true,
  hintStyle: kBody,
  fillColor: kPurple20,
);

///-------DateTime Constants -------////
///
Map<int, String> monthsOfYear = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};
