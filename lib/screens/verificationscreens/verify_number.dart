
import 'package:flutter/material.dart';

import '../../constants.dart';


class VerifyNumber extends StatefulWidget {
  const VerifyNumber({ Key? key }) : super(key: key);

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height *.9,
     decoration: const BoxDecoration(
       color: Colors.red,
       borderRadius: BorderRadius.only(
         topLeft: Radius.circular(28),
         topRight:Radius.circular(28),
       )
     ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
               Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Add a Number",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: kPurple),
                      ),
                    ),
          ]
        )
      )
    );
  }
}