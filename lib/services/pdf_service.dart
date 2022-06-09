import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:wemo/constants.dart';
import 'package:wemo/services/qr_service.dart';

class PDFService {
  Future<Uint8List> createWemoPdf(
      {required String name, required String number}) async {
    String qrData = QrService().joinNameNUmber(number: number, name: name);

    //creating and Saving the pdf
    final pdf = pw.Document();
//Creat the image and get the file path
    final String qrImagePath = await QrService().createQRImage(qrData);
//use the file path to load the image
    final qrImage = (await rootBundle.load(qrImagePath)).buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: ((pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(kDefaultPadding2x),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.SvgImage(
                  svg: "assets/svg/wemo_logo.svg",
                ),
                pw.Text("Simplify your Mobile Money transactions"),

                ///TODO: add svg logo here
                pw.Image(pw.MemoryImage(qrImage),
                    width: 150, height: 150, fit: pw.BoxFit.cover),
                pw.Spacer(),
                pw.Text(
                  name,
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: const PdfColor.fromInt(0xFF531CF7)),
                ),
                pw.Text(
                  number,
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: const PdfColor.fromInt(0xFF353535)),
                ),
                pw.Spacer(),
              ],
            ),
          );
        }),
      ),
    );

    return pdf.save();
  }

  Future<void> savePDFFIle(String fileName, Uint8List byteList) async {
    //Dealing with file directories
    final output = await getTemporaryDirectory();
    String filePath = "${output.path}/$fileName Wemo Code.pdf";
    final file = File(filePath);
    //Write the file to disk
    await file.writeAsBytes(byteList);
    //Open the Document
  //  await OpenDocument.openDocument(filePath: filePath);
  }
}
