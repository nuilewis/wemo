import 'package:flutter/foundation.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wemo/constants.dart';

class QrService {
  ///Interpolate name and number into a single string to feed to tthe GR generator

  ///INterpolating the Name and nUmber Strings

  String joinNameNUmber({required String number, required String name}) {
    // String numToString = number.toString();

    String joinedString = number + name;
    debugPrint("joined string is $joinedString");
    return joinedString;
  }

  ///Create and Save a QR Image
  // Future<void> writeToFile(ByteData? data, String filePath) async {
  //   final buffer = data!.buffer;
  //   await File(filePath).writeAsBytes(
  //       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  // }

  Future<Uint8List?> createQRImage(String data) async {
    final qrValidationResult = QrValidator.validate(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L);

    QrCode? wemoQrCode;

    if (qrValidationResult.status == QrValidationStatus.valid) {
      wemoQrCode = qrValidationResult.qrCode;
      final painter = QrPainter.withQr(
        qr: wemoQrCode!,
        color: kPurple,
        gapless: false,
        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
        dataModuleStyle:
            const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
      );

      ///Returning the picture data as a Uint8List

      final picture = await painter.toImageData(2048);

      final Uint8List pictureUint8List = picture!.buffer.asUint8List();
      return pictureUint8List;
    } else {
      qrValidationResult.error;
    }

    // Map<String, String> imageinfo = {
    //   "qrData": data,
    //   "imgSize": "2048",
    // };
    // final picture =
    //     await compute<Map<String, String>, ByteData?>(buildImage, imageinfo);

    return null;
  }
}
