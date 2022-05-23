import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WemoTitle extends StatelessWidget {
  final bool showIcon;
  final String title;
  final String? iconLink;
  final Color? textColor;
  const WemoTitle({
    Key? key,
    required this.showIcon,
    required this.title,
    required this.iconLink,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showIcon
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    .copyWith(fontSize: 18, color: textColor ?? Colors.white),
              ),
            ],
          )
        : Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 18, color: textColor ?? Colors.white),
          );
  }
}
