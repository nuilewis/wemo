import 'package:flutter/material.dart';

import '../constants.dart';

void wemoSnackBar(BuildContext context,
    {required String message, required bool isSuccess}) {
  final customSnackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 20,
    margin: const EdgeInsets.symmetric(
        vertical: kDefaultPadding2x - 8, horizontal: kDefaultPadding),
    padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding2x - 8, horizontal: kDefaultPadding),
    backgroundColor: isSuccess ? kGreen : kFuchsia,
    content: Text(
      message,
      style: isSuccess
          ? Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white)
          : Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(customSnackBar);
}
