import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class RoundedButton extends StatelessWidget {
  final String iconLink;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? iconColor;

  const RoundedButton(
      {Key? key,
      required this.iconLink,
      required this.onPressed,
      this.bgColor,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 72,
        width: 72,
        padding: const EdgeInsets.all(kDefaultPadding + 10),
        decoration: BoxDecoration(
          color: bgColor ?? kPurple,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: bgColor ?? kPurple.withOpacity(.3),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(3, 5),
            )
          ],
        ),
        child: SvgPicture.asset(
          "assets/svg/forward_icon.svg",
          color: iconColor ?? Colors.white,
        ),
      ),
    );
  }
}
