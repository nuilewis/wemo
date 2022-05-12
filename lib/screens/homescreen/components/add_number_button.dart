import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class AddNumberButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddNumberButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: kPurple20,
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
        ),
        child: Center(
            child:
                SvgPicture.asset("assets/svg/plus_icon.svg", color: kPurple)),
      ),
    );
  }
}
