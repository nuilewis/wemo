import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';


class WemoButton extends StatelessWidget {
  final String title;
  final String? iconLink;
  final bool showIcon;
  final Color? textColor;
  final Color? bgColor;
  final VoidCallback onPressed;
  const WemoButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.iconLink,
    this.showIcon = false,
    this.textColor,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        alignment: Alignment.center,
        height: 64,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64),
          color: bgColor ?? kPurple,
        ),
        child: showIcon
            ? Row(
                children: [
                  SvgPicture.asset(
                    iconLink ?? "",
                    color: textColor ?? Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18),
                  ),
                ],
              )
            : Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18, color: textColor ?? Theme.of(context).textTheme.headline1!.color),
              ),
      ),
    );
  }
}
