import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class AddNumberButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool showText;

  const AddNumberButton({
    Key? key,
    required this.onPressed,
    this.showText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          margin: const EdgeInsets.all(kDefaultPadding),
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPurple20,
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          child: showText
              ? Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/svg/plus_icon.svg",
                          color: kPurple),
                      const SizedBox(
                        width: kDefaultPadding - 8,
                      ),
                      Text(
                        "Add Number",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 20, color: kPurple),
                      )
                    ],
                  ),
                )
              : Center(
                  child: SvgPicture.asset("assets/svg/plus_icon.svg",
                      color: kPurple),
                )),
    );
  }
}
