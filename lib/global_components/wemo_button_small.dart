import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class WemoButtonSmall extends StatelessWidget {
  final String title;
  final String? iconLink;
  final bool showIcon;
  final Color? textColor;
  final Color? bgColor;
  final VoidCallback onPressed;
  const WemoButtonSmall(
      {Key? key,
      required this.title,
      this.iconLink,
      required this.showIcon,
      this.textColor,
      this.bgColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        alignment: Alignment.center,
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: bgColor ?? kPurple,
        ),
        child: showIcon
            ? Row(
                mainAxisSize: MainAxisSize.min,
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
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        color: textColor ??
                            Theme.of(context).textTheme.headline1!.color),
                  ),
                ],
              )
            : Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                      color: textColor ??
                          Theme.of(context).textTheme.headline1!.color),
                ),
              ),
      ),
    );
  }
}
