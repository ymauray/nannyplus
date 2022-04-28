import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../cubit/invoice_view_cubit.dart';
import '../data/model/child.dart';
import '../data/model/invoice.dart';
import '../data/model/service.dart';
import '../utils/date_format_extension.dart';
import '../utils/list_extensions.dart';
import '../utils/prefs_util.dart';
import '../views/app_view.dart';
import '../widgets/loading_indicator.dart';

class InvoiceView extends StatelessWidget {
  const InvoiceView(
    this.invoice,
    this.gettext, {
    Key? key,
  }) : super(key: key);

  final Invoice invoice;
  final GettextLocalizations gettext;

  @override
  Widget build(BuildContext context) {
    context.read<InvoiceViewCubit>().init(invoice);

    return BlocBuilder<InvoiceViewCubit, InvoiceViewState>(
      builder: (context, state) => AppView(
        title: Text(context.t('Invoice {0}', args: [invoice.number])),
        body: state is InvoiceViewLoaded
            ? FutureBuilder<pw.Document>(
                future: (() async {
                  var prefs = await PrefsUtil.getInstance();
                  var line1FontAsset = prefs.line1FontAsset;
                  final byteData1 = line1FontAsset.isNotEmpty
                      ? await rootBundle.load(line1FontAsset)
                      : null;
                  final line1Font =
                      byteData1 != null ? pw.Font.ttf(byteData1) : null;

                  var line2FontAsset = prefs.line2FontAsset;
                  final byteData2 = line2FontAsset.isNotEmpty
                      ? await rootBundle.load(prefs.line2FontAsset)
                      : null;
                  final line2Font =
                      byteData2 != null ? pw.Font.ttf(byteData2) : null;

                  var conditions = prefs.conditions;
                  var groupedServices =
                      state.services.groupBy((service) => service.date);
                  var services = groupedServices.fold<List<Service>>(
                    [],
                    (previousValue, group) =>
                        previousValue..addAll(group.value),
                  );

                  final applicationDirectory =
                      await getApplicationDocumentsDirectory();
                  final appDocumentsPath = applicationDirectory.path;
                  final filePath = '$appDocumentsPath/logo';
                  final file = File(filePath);

                  var packs = <List<Service>>[];
                  var currentPack = <Service>[];
                  String previousDate = "";
                  var count = 0.0;
                  for (var service in services) {
                    if (previousDate != service.date) {
                      if (count >= 15.5) {
                        packs.add(currentPack);
                        currentPack = <Service>[];
                        count = 0;
                        previousDate = "";
                      }
                      count += 1.5;
                      previousDate = service.date;
                    }
                    currentPack.add(service);
                    if (count >= 17) {
                      packs.add(currentPack);
                      currentPack = <Service>[];
                      count = 0;
                      previousDate = "";
                    }
                    count += 1;
                  }
                  if (currentPack.isNotEmpty) {
                    packs.add(currentPack);
                  }
                  if ((count == 1) || (count >= 12)) {
                    packs.add([]);
                  }

                  var doc = pw.Document();
                  var childrenMap = Map<int, Child>.fromIterable(
                    state.children,
                    key: (child) => child.id,
                  );

                  for (var i = 0; i < packs.length; i++) {
                    var pack = packs[i];
                    var rows = ((List<Service> services) sync* {
                      String previousDate = "";
                      int previousChildId = -1;
                      for (var i = 0; i < services.length; i++) {
                        var service = services[i];
                        var newBloc = service.date != previousDate;
                        var newChild =
                            newBloc || (service.childId != previousChildId);
                        previousDate = service.date;
                        previousChildId = service.childId;
                        if (newBloc) {
                          yield pw.TableRow(
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                bottom: pw.BorderSide(color: PdfColors.grey),
                              ),
                            ),
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: pw.Text(
                                  service.date.formatDate(),
                                  textAlign: pw.TextAlign.left,
                                  style: const pw.TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          );
                        }
                        yield pw.TableRow(
                          children: [
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 4.0),
                              child: pw.Text(
                                state.children.length == 1
                                    ? ""
                                    : newChild
                                        ? childrenMap[service.childId]!
                                            .firstName
                                        : "",
                                style: pw.TextStyle(
                                  inherit: true,
                                  fontStyle: pw.FontStyle.italic,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 4.0),
                              child: pw.Text(
                                service.priceLabel!,
                                textAlign: pw.TextAlign.left,
                                style: const pw.TextStyle(fontSize: 14),
                              ),
                            ),
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 4.0),
                              child: pw.Text(
                                service.isFixedPrice == 1
                                    ? '-'
                                    : (service.hours.toString() +
                                        "h" +
                                        service.minutes
                                            .toString()
                                            .padLeft(2, '0') +
                                        ' x ' +
                                        service.priceAmount!
                                            .toStringAsFixed(2)),
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 14),
                              ),
                            ),
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 4.0),
                              child: pw.Text(
                                service.total.toStringAsFixed(2),
                                textAlign: pw.TextAlign.right,
                                style: const pw.TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        );
                      }
                    })(pack.toList());

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
                                    prefs.line1,
                                    prefs.line2,
                                    line1Font,
                                    line2Font,
                                  ),
                                  invoiceTitle(state.children),
                                  invoiceMeta(),
                                  invoiceTable(rows),
                                  if (i == packs.length - 1)
                                    invoiceTotal(conditions),
                                  if (i == packs.length - 1)
                                    pw.Column(
                                      children: [
                                        pw.Row(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Expanded(
                                              child: pw.Column(
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [
                                                  if (prefs
                                                      .bankDetails.isNotEmpty)
                                                    blueText(
                                                      gettext.t(
                                                        'Bank details',
                                                        null,
                                                      ),
                                                    ),
                                                  if (prefs
                                                      .bankDetails.isNotEmpty)
                                                    pw.Text(
                                                      prefs.bankDetails,
                                                    ),
                                                ],
                                              ),
                                            ),
                                            pw.Expanded(
                                              child: pw.Column(
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.end,
                                                children: [
                                                  if (prefs.address.isNotEmpty)
                                                    blueText(gettext.t(
                                                      'Address',
                                                      null,
                                                    )),
                                                  if (prefs.address.isNotEmpty)
                                                    pw.Text(
                                                      prefs.address,
                                                      textAlign:
                                                          pw.TextAlign.right,
                                                    ),
                                                ],
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
                  }

                  return doc;
                })(),
                builder: (context, snapshot) {
                  return PdfPreview(
                    build: (pageFormat) => snapshot.data!.save(),
                  );
                },
              )
            : const LoadingIndicator(),
      ),
    );
  }

  pw.Column invoiceTotal(String conditions) {
    return pw.Column(
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
            pw.Text(conditions, style: const pw.TextStyle(fontSize: 12)),
          ],
        ),
        pw.SizedBox(height: 42),
      ],
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
                blueText(gettext.t("Date", null)),
                blueText(gettext.t("Service", null)),
                blueText(
                  gettext.t("Hours", null),
                  textAlign: pw.TextAlign.center,
                ),
                blueText(
                  gettext.t("Price", null),
                  textAlign: pw.TextAlign.right,
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

  pw.Padding blueText(String text, {pw.TextAlign? textAlign}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Text(
        text,
        textAlign: textAlign ?? pw.TextAlign.left,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 14,
          color: PdfColors.blue,
        ),
      ),
    );
  }

  pw.Column invoiceMeta() {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            invoiceMetaLeft(),
            invoiceMetaRight(),
          ],
        ),
        pw.SizedBox(height: 18),
      ],
    );
  }

  pw.Expanded invoiceMetaRight() {
    return pw.Expanded(
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
    );
  }

  pw.Expanded invoiceMetaLeft() {
    return pw.Expanded(
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
          pw.SizedBox(height: 8),
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
    );
  }

  pw.Widget invoiceTitle(List<Child> children) {
    String childName = children[0].displayName;
    if (children.length > 1) {
      childName = children
              .take(children.length - 1)
              .map((child) => child.firstName)
              .join(", ") +
          " " +
          gettext.t("and", null) +
          " " +
          children.last.firstName;
    }

    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Container(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8),
                  child: pw.Text(
                    gettext.t("Invoice for {0}", [childName]),
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
              crossAxisAlignment: pw.CrossAxisAlignment.start,
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
