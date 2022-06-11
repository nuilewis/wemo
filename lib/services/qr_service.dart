import 'dart:typed_data';
import 'dart:ui';
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

  Future<Uint8List?> createQRImage(String data) async {
    final qrValidationResult = QrValidator.validate(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L);
    //Validating the QR Code
    QrCode? wemoQrCode;
    if (qrValidationResult.status == QrValidationStatus.valid) {
      wemoQrCode = qrValidationResult.qrCode;
      //Painting the QR Image
      final painter = QrPainter.withQr(
        qr: wemoQrCode!,
        color: kPurple,
        gapless: false,
        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
        dataModuleStyle:
            const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
      );

      ///Returning the picture data as a Uint8List

      final picture =
          await painter.toImageData(4096, format: ImageByteFormat.png);

      final Uint8List pictureUint8List = picture!.buffer.asUint8List();
      // await writeToFile(picData, imagePath);
      return pictureUint8List;
    } else {
      qrValidationResult.error;
    }
    return null;
  }

  // Future<void> writeToFile(ByteData? data, String filePath) async {
  //   final buffer = data!.buffer;
  //   await File(filePath).writeAsBytes(
  //       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  // }
}
