import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../global_components/wemo_text_title.dart';

class ExpandedSendOptions extends StatelessWidget {
  final VoidCallback onScanPressed;
  final VoidCallback onNumberPressed;
  const ExpandedSendOptions(
      {Key? key, required this.onScanPressed, required this.onNumberPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding2x),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding + 8),
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 30, color: kPurple20)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onScanPressed,
            child: const WemoTitle(
              textColor: kPurple80,
              title: "Scan",
              showIcon: true,
              iconLink: "assets/svg/scan_icon.svg",
            ),
          ),
          const SizedBox(height: kDefaultPadding2x),
          GestureDetector(
            onTap: onNumberPressed,
            child: const WemoTitle(
              textColor: kPurple80,
              title: "Input Number",
              showIcon: true,
              iconLink: "assets/svg/rounded_plus_icon.svg",
            ),
          ),
        ],
      ),
    );
  }
}
