import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/utils/prefs_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';

import '../data/model/invoice.dart';
import '../data/services_repository.dart';
import '../utils/date_format_extension.dart';
import '../views/app_view.dart';

class InvoiceView extends StatelessWidget {
  final Invoice invoice;
  final GettextLocalizations gettext;
  const InvoiceView(this.invoice, this.gettext, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView(
      title: Text(context.t('Invoice {0}', args: [invoice.number])),
      body: FutureBuilder<pw.Document>(
        future: (() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var conditions = prefs.getString('conditions');

          var servicesRepository = const ServicesRepository();
          var services =
              await servicesRepository.getServicesForInvoice(invoice.id);

          final applicationDirectory = await getApplicationDocumentsDirectory();
          final appDocumentsPath = applicationDirectory.path;
          final filePath = '$appDocumentsPath/logo';
          final file = File(filePath);

          var rows = services.map(
            (service) => pw.TableRow(
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.grey),
                ),
              ),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
                  child: pw.Text(
                    service.date.formatDate(),
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
                  child: pw.Text(
                    service.priceLabel!,
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
                  child: pw.Text(
                    service.isFixedPrice == 1
                        ? '-'
                        : (service.hours.toString() +
                            ":" +
                            service.minutes.toString().padLeft(2, '0')),
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
                  child: pw.Text(
                    service.total.toStringAsFixed(2),
                    textAlign: pw.TextAlign.right,
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );

          //final byteData = await rootBundle.load('assets/fonts/STCaiyun.ttf');
          var line1FontAsset = PrefsUtil.getInstance().line1FontAsset;
          final byteData1 = line1FontAsset.isNotEmpty
              ? await rootBundle.load(line1FontAsset)
              : null;
          final line1Font = byteData1 != null ? pw.Font.ttf(byteData1) : null;

          var line2FontAsset = PrefsUtil.getInstance().line2FontAsset;
          final byteData2 = line2FontAsset.isNotEmpty
              ? await rootBundle.load(PrefsUtil.getInstance().line2FontAsset)
              : null;
          final line2Font = byteData2 != null ? pw.Font.ttf(byteData2) : null;

          var doc = pw.Document();
          doc.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              margin: const pw.EdgeInsets.all(20),
              build: (pw.Context context) {
                return pw.Stack(
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        invoiceHeader(
                          PrefsUtil.getInstance().line1,
                          PrefsUtil.getInstance().line2,
                          line1Font,
                          line2Font,
                        ),
                        invoiceTitle(),
                        invoiceMeta(),
                        invoiceTable(rows),
                        pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    gettext.t('Total incl. VAT', null) + " : ",
                                    style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.blue,
                                    ),
                                    textAlign: pw.TextAlign.right,
                                  ),
                                ),
                                pw.Text(
                                  invoice.total.toStringAsFixed(2),
                                  style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.right,
                                ),
                              ],
                            ),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Text(
                                  conditions ?? 'Payment conditions not set',
                                  style: const pw.TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (file.existsSync())
                      pw.Positioned(
                        right: 0,
                        top: 0,
                        child: pw.Image(
                          pw.MemoryImage(
                            file.readAsBytesSync(),
                          ),
                          height: 120,
                          fit: pw.BoxFit.contain,
                        ),
                      ),
                  ],
                );
              },
            ),
          );

          return doc;
        })(),
        builder: (context, snapshot) {
          return PdfPreview(build: (pageFormat) => snapshot.data!.save());
        },
      ),
    );
  }

  pw.Widget invoiceTable(Iterable<pw.TableRow> rows) {
    return pw.Column(
      children: [
        pw.Table(
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: PdfColors.black,
                  ),
                ),
              ),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Text(
                    gettext.t("Date", null),
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                      color: PdfColors.blue,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Text(
                    gettext.t("Service", null),
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                      color: PdfColors.blue,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Text(
                    gettext.t("Hours", null),
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                      color: PdfColors.blue,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Text(
                    gettext.t("Price", null),
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                      color: PdfColors.blue,
                    ),
                  ),
                ),
              ],
            ),
            ...rows,
          ],
        ),
        pw.SizedBox(height: 28),
      ],
    );
  }

  pw.Column invoiceMeta() {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 1,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    gettext.t("Invoice number", null),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue,
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    invoice.number.toString().padLeft(6, '0'),
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              flex: 1,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    gettext.t("Invoiced to", null),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue,
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    invoice.parentsName,
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                  pw.Text(
                    invoice.address,
                    style: const pw.TextStyle(
                      inherit: true,
                      fontSize: 14,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 14),
        pw.Row(
          children: [
            pw.Expanded(
              flex: 1,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    gettext.t("Date", null),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue,
                      fontSize: 14,
                    ),
                  ),
                  pw.Text(
                    invoice.date.formatDate(),
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 14),
      ],
    );
  }

  pw.Widget invoiceTitle() {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Container(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8),
                  child: pw.Text(
                    gettext.t("Invoice for {0}", ["tmpName"]),
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 28),
      ],
    );
  }

  pw.Widget invoiceHeader(
    String? title1,
    String? title2,
    pw.Font? line1Font,
    pw.Font? line2Font,
  ) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Column(
              children: [
                pw.Text(
                  title1 ?? 'Title 1 not set',
                  style: pw.TextStyle(
                    font: line1Font,
                    fontSize: 30,
                  ),
                ),
                pw.Text(
                  title2 ?? 'Title 2 not set',
                  style: pw.TextStyle(
                    font: line2Font,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 45),
      ],
    );
  }
}
