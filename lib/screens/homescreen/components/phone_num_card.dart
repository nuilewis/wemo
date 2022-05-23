import 'package:flutter/material.dart';

import '../../../constants.dart';

class PhoneNumberCard extends StatelessWidget {
  const PhoneNumberCard({
    Key? key,
    required this.number,
    required this.name,
    required this.network,
  }) : super(key: key);

  final String number;
  final String name;
  final String network;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: kDefaultPadding),
      height: 120,
      width: screenSize.width * .8,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: kPurple20,
              offset: Offset(5, 10),
              blurRadius: 20,
              spreadRadius: 8,
            ),
          ],
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
          gradient: const LinearGradient(
              colors: [kPurple, kBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      padding: const EdgeInsets.all(kDefaultPadding),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            network,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
