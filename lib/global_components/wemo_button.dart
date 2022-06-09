import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class WemoButton extends StatelessWidget {
  final String title;
  final String? iconLink;

  final bool showIcon;
  final bool isSecondary;
  final Color? textColor;
  final Color? bgColor;
  final bool isSmall;
  final bool? isDoingWork;
  final VoidCallback? onPressed;
  const WemoButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.iconLink,
    this.showIcon = false,
    this.isSecondary = false,
    this.isSmall = false,
    this.isDoingWork = false,
    this.textColor,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSecondary == true && textColor != null) {
      throw UnimplementedError(
          "Error, cannot define isSecondary = true and textColor simultaneously, as textColor defaults to bgColor when isSecondary is set to true, Consider removing the textColor parameter :)");
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: isDoingWork! ? null: const EdgeInsets.all(kDefaultPadding),
        alignment: Alignment.center,
        height: isSmall ? 56 : 64,
        width: double.infinity,
        decoration: BoxDecoration(
          border: isSecondary
              ? Border.all(color: bgColor ?? kPurple, width: 2)
              : null,
          borderRadius: BorderRadius.circular(64),
          color: isSecondary ? Colors.transparent : bgColor ?? kPurple,
        ),
        child: isDoingWork!
            ? const Center(
                child:  CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : showIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        iconLink ?? "",
                        color: isSecondary
                            ? bgColor ?? kPurple
                            : textColor ?? Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18,
                            color: isSecondary
                                ? bgColor ?? kPurple
                                : textColor ?? Colors.white),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          color: isSecondary
                              ? bgColor ?? kPurple
                              : textColor ?? Colors.white),
                    ),
                  ),
      ),
    );
  }
}
