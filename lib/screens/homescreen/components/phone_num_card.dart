import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class PhoneNumberCard extends StatelessWidget {
  const PhoneNumberCard({
    Key? key,
    required this.number,
    required this.name,
    required this.network,
    required this.onDelete,
    required this.onSelected,

  }) : super(key: key);

  final String number;
  final String name;
  final String network;
  final VoidCallback onDelete;
  final bool onSelected;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(right: kDefaultPadding),
      height: 120,
      width: screenSize.width * .8,
      decoration: BoxDecoration(
          boxShadow: const [
             BoxShadow(
              color:  kPurple20 ,
              offset: Offset(5, 10),
              blurRadius: 20,
              spreadRadius: 8,
            ),
          ],
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
          gradient: LinearGradient(
              colors: onSelected ? [kPurple, kBlue] : [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      // padding: const EdgeInsets.all(kDefaultPadding),
      alignment: Alignment.topLeft,
      child: Stack(
        children: [
          Positioned(
            left: kDefaultPadding,
            top: kDefaultPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: onSelected? Colors.white : Theme.of(context).iconTheme.color),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: onSelected? Colors.white : Theme.of(context).iconTheme.color),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  network,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color:  onSelected? Colors.white : Theme.of(context).iconTheme.color),
                ),
              ],
            ),
          ),
          Positioned(
            right: kDefaultPadding / 2,
            bottom: kDefaultPadding / 2,
            child: IconButton(
                onPressed: onDelete,
                icon: SvgPicture.asset(
                  "assets/svg/trash_icon.svg",
                  color:  onSelected? Colors.white : kFuchsia
                )),
          )
        ],
      ),
    );
  }
}
