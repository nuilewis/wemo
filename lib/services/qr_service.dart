import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<String> createQRImage(String data) async {
    final qrValidationResult = QrValidator.validate(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L);
    //Validating thee QR Code
    QrCode? wemoQrCode;
    if (qrValidationResult.status == QrValidationStatus.valid) {
      wemoQrCode = qrValidationResult.qrCode;
      //Paining the QR Image
      final painter = QrPainter.withQr(
        qr: wemoQrCode!,
        color: kPurple,
        gapless: false,
        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
        dataModuleStyle:
            const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
      );

      //Creating the image file
      final tempDir = await getTemporaryDirectory();
      final String ts = DateTime.now().millisecondsSinceEpoch.toString();
      String imagePath = "${tempDir.path}/wemo qr image $ts.png";
      //Export the image file

      final picData =
          await painter.toImageData(2048, format: ImageByteFormat.png);
      await writeToFile(picData, imagePath);
      return imagePath;
    } else {
      qrValidationResult.error;
    }
    return "";
  }

  Future<void> writeToFile(ByteData? data, String filePath) async {
    final buffer = data!.buffer;
    await File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
