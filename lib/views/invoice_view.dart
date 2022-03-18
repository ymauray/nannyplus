import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';

import '../data/model/child.dart';
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
      title: Text(context.t('Invoice #{0}', args: [invoice.number])),
      body: FutureBuilder<pw.Document>(
        future: (() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var title1 = prefs.getString('title1');
          var title2 = prefs.getString('title2');
          var conditions = prefs.getString('conditions');

          var servicesRepository = const ServicesRepository();
          var services =
              await servicesRepository.getServicesForInvoice(invoice.id);

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
                    service.price.toStringAsFixed(2),
                    textAlign: pw.TextAlign.right,
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );

          final byteData =
              await rootBundle.load('assets/fonts/chinese.stcaiyun.ttf');
          final font = pw.Font.ttf(byteData);

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
                        invoiceHeader(title1, title2, font),
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
                                  conditions ??
                                      'Facture payable sous 10 jours, par virement bancaire ou par TWINT',
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
                    gettext.t("Prestation", null),
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
            ...rows
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
                        fontSize: 14),
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
                        fontSize: 14),
                  ),
                  pw.Text(
                    invoice.parentsName,
                    style: const pw.TextStyle(fontSize: 14),
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
                        fontSize: 14),
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

  pw.Widget invoiceHeader(String? title1, String? title2, pw.Font font) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Column(
              children: [
                pw.Text(
                  title1 ?? 'SANDRINE KOHLER',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 30,
                  ),
                ),
                pw.Text(
                  title2 ?? 'Les petits ours blancs',
                  style: const pw.TextStyle(
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
