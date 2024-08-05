// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_is_empty, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last, unused_local_variable, file_names, non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_code_pas/main.dart';

class HomeController extends GetxController {
  void downloadCatalog() async {
    final pdf = pw.Document();
    Uint8List fontData = File('assets/font/static/Inter.ttf').readAsBytesSync();
var data = fontData.buffer.asByteData();
var myFont = pw.Font.ttf(data);
var myStyle = pw.TextStyle(font: myFont);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(children: [
            pw.Center(
                child: pw.Text("Catalog products",
                    style: myStyle)),
            pw.SizedBox(height: 20),
            pw.Table(
                border: pw.TableBorder.all(
                    color: PdfColor.fromHex("#000000"), width: 2),
                children: [
                  pw.TableRow(children: [
                    pw.Text("No",
                        style: myStyle),
                    pw.Text("Product code",
                        style:myStyle),
                    pw.Text("Quantity",
                        style: myStyle),
                    pw.Text("QR Code",
                        style: myStyle)
                  ]),
                  //isi datanya
                  ...List.generate(5, (index){
                    return pw.TableRow(children: [
                    pw.Text("${index +1}",
                        style: myStyle),
                    pw.Text("Product code",
                        style: myStyle),
                    pw.Text("Quantity",
                        style: myStyle),
                    pw.Text("QR Code",
                        style: myStyle)
                  ]);
                  } )
                ])
          ]);
        }));

    // Simpan
    Uint8List bytes = await pdf.save();

    // Buat file kosong
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    // Memasukkan data bytes
    await file.writeAsBytes(bytes);
    print("File saved at: ${file.path}");

    // Buka pdf
    try {
      await OpenFile.open(file.path);
      print("File opened successfully");
    } catch (e) {
      print("Error opening file: $e");
    }
  }
}
