import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../constants.dart';

class ShowQRCode extends StatelessWidget {
  ShowQRCode({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;
  final qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return RepaintBoundary(
      key: qrKey,
      child: QrImageView(
        data: data,
        size: screenSize.width * .6,
        foregroundColor: kPurple,
        gapless: false,
        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle, color: kPurple),
        dataModuleStyle:
            const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
        version: QrVersions.auto,
        semanticsLabel: "Simplify your momo transactions with Wemo",
      ),
    );
  }
}
