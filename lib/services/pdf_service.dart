import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wemo/constants.dart';
import 'package:wemo/global_components/wemo_snackbar.dart';

import 'package:wemo/services/qr_service.dart';

class PDFService {
  Future<Uint8List> createWemoPdf(
      {required String name, required String number}) async {
    String qrData = QrService().joinNameNUmber(number: number, name: name);

    const PdfColor kPdfPurple = PdfColor.fromInt(0xFF531CF7);
    const PdfColor kPdfDark = PdfColor.fromInt(0xFF353535);
    // const PdfColor kPdfTransparent = PdfColor.fromInt(0x00ffffff);
    // const PdfColor kPdfWhite = PdfColor.fromInt(0xffffffff);

    //creating and Saving the pdf
    final pdf = pw.Document();
    final Uint8List? qrImageData = await QrService().createQRImage(qrData);

    final wemoLogo = (await rootBundle.load("assets/images/wemo_logo.png"))
        .buffer
        .asUint8List();

    ///Declaring the custom font
    final fontData = await rootBundle.load("assets/fonts/Urbanist-Regular.ttf");
    final fontDataBold =
        await rootBundle.load("assets/fonts/Urbanist-SemiBold.ttf");
    final urbanist = pw.Font.ttf(fontData);
    final urbanistBold = pw.Font.ttf(fontDataBold);

////------------Building the Page Template--------///
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(PdfPageFormat.a4.width * .05),
        build: ((pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(kDefaultPadding2x),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                //  pw.SvgImage(svg: "assets/svg/send_icon.svg"),
                pw.Image(pw.MemoryImage(wemoLogo),
                    width: PdfPageFormat.a4.width * .3),

                pw.Text(
                  "Simplify your Mobile Money transactions",
                  style: pw.TextStyle(
                    font: urbanist,
                    fontSize: 18,
                  ),
                ),
                pw.Spacer(),

                pw.Center(
                  child: pw.Container(
                    width: PdfPageFormat.a4.width * .5,
                    height: PdfPageFormat.a4.width * .5,
                    child: pw.Image(
                      pw.MemoryImage(qrImageData!),
                    ),
                  ),
                ),

                pw.Spacer(),
                pw.Text(
                  name,
                  style: pw.TextStyle(
                      font: urbanistBold,
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: kPdfPurple),
                ),
                pw.SizedBox(height: kDefaultPadding),
                pw.Text(
                  number,
                  style: pw.TextStyle(
                      font: urbanist,
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: kPdfDark),
                ),
                pw.Spacer(flex: 2),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.RichText(
                    text: pw.TextSpan(
                      children: [
                        pw.TextSpan(
                          text: "Transferred With",
                          style: pw.TextStyle(
                            font: urbanist,
                            fontSize: 18,
                            color: kPdfDark,
                          ),
                        ),
                        pw.TextSpan(
                          text: " Wemo",
                          style: pw.TextStyle(
                            font: urbanistBold,
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: kPdfPurple,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
    return await pdf.save();
  }

  Future<void> savePDFFIle(
      BuildContext context, String fileName, Uint8List fileData) async {
    late Directory outputDir;
    //Check permissions and Do the needful
    await checkPermission();
    if (Platform.isAndroid) {
      outputDir = Directory("/storage/emulated/0/Documents");
    } else if (Platform.isIOS) {
      outputDir = await getApplicationDocumentsDirectory();
    }

    String filePath = "${outputDir.path}/$fileName Wemo Code.pdf";
    final file = File(filePath);
    //Write the file to disk
    await file.writeAsBytes(fileData).then((value) {
      return wemoSnackBar(context, message: "Saved!", isSuccess: true);
    });
  }
}

Future<void> checkPermission() async {
  ////Manage External Storage Permission
  // Permission writeExternalStoragePermission = Permission.
  // if (await writeExternalStoragePermission.status.isGranted) {
  //
  //   return;
  // } else {
  //   await writeExternalStoragePermission.request();
  // }

  ///Storage Permission
  Permission storagePermission = Permission.storage;
  if (await storagePermission.isGranted) {
    return;
  } else {
    await storagePermission.request();
  }
}
