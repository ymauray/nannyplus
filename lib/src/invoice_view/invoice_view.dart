import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:nannyplus/cubit/child_info_cubit.dart';
import 'package:nannyplus/cubit/invoice_view_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/src/common/loading_indicator.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/date_format_extension.dart';
import 'package:nannyplus/utils/list_extensions.dart';
import 'package:nannyplus/utils/prefs_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceView extends StatelessWidget {
  const InvoiceView(
    this.invoice,
    this.gettext, {
    super.key,
  });

  final Invoice invoice;
  final GettextLocalizations gettext;

  @override
  Widget build(BuildContext context) {
    context.read<InvoiceViewCubit>().init(invoice);

    return BlocBuilder<InvoiceViewCubit, InvoiceViewState>(
      builder: (context, state) => UIView(
        title: BlocBuilder<ChildInfoCubit, ChildInfoState>(
          builder: (context, state) => state is ChildInfoLoaded
              ? Text(state.child.displayName)
              : Text(context.t('Loading...')),
        ),
        persistentHeader: UISliverCurvedPersistenHeader(
          child: Text(
            context.t(
              'Invoice of {0}',
              args: [
                invoice.date.formatDate(),
              ],
            ),
          ),
        ),
        body: state is InvoiceViewLoaded
            ? _DocumentBuilder(state, invoice, gettext)
            : const LoadingIndicator(),
      ),
    );
  }
}

class _DocumentBuilder extends StatelessWidget {
  const _DocumentBuilder(this.state, this.invoice, this.gettext);

  final InvoiceViewLoaded state;
  final Invoice invoice;
  final GettextLocalizations gettext;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<pw.Document>(
      future: (() async {
        final prefs = await PrefsUtil.getInstance();
        final line1Font = await _getLine1Font(prefs);
        final line2Font = await _getLine2Font(prefs);

        final conditions = prefs.conditions;
        final groupedServices =
            state.services.groupBy((service) => service.date);

        final logoFile = await _getLogoFile();

        final doc = pw.Document();
        final childrenMap = {
          for (final child in state.children) child.id!: child
        };

        var maxHeight = 15.0;
        var currentHeight = 0.0;
        var page = 1;
        final pages = <List<Group<String, Service>>>[[]];
        for (final group in groupedServices) {
          final groupHeight = 1.5 + group.value.length;
          if (groupHeight + currentHeight > maxHeight) {
            pages.add([]);
            page += 1;
            maxHeight = 30.0;
            currentHeight = 0;
          }
          currentHeight += groupHeight;
          pages[page - 1].add(group);
        }

        // We need space to add the bank account number.
        // If we are too close to the bottom of the page,
        // we need to start a new page.
        if (currentHeight > 11.0) {
          pages.add([]);
        }

        for (var page = 0; page < pages.length; page++) {
          doc.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              margin: const pw.EdgeInsets.all(50),
              build: (context) {
                return pw.Stack(
                  children: [
                    // Page 1 has the header
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (page == 0)
                          invoiceHeader(
                            prefs.line1,
                            prefs.line2,
                            line1Font,
                            line2Font,
                          ),
                        if (page == 0) invoiceTitle(state.children),
                        if (page == 0) invoiceMeta(),
                        if (page == 0) invoiceTotal(conditions),
                        if (pages[page].isEmpty) pw.Container(),
                        if (pages[page].isNotEmpty)
                          invoiceTable(_buildTable(pages, page, childrenMap)),
                      ],
                    ),
                    if (page == 0 && logoFile.existsSync())
                      pw.Positioned(
                        right: 0,
                        top: 0,
                        child: pw.Image(
                          pw.MemoryImage(
                            logoFile.readAsBytesSync(),
                          ),
                          height: 120,
                        ),
                      ),
                    if (page == pages.length - 1)
                      pw.Positioned(
                        left: 0,
                        bottom: pages[page].isNotEmpty ? 0 : null,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            if (prefs.bankDetails.isNotEmpty)
                              blueText(
                                gettext.t(
                                  'Bank details',
                                  null,
                                ),
                              ),
                            if (prefs.bankDetails.isNotEmpty)
                              pw.Text(
                                prefs.bankDetails,
                              ),
                          ],
                        ),
                      ),
                    if (page == pages.length - 1)
                      pw.Positioned(
                        right: 0,
                        bottom: pages[page].isNotEmpty ? 0 : null,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            if (prefs.address.isNotEmpty)
                              blueText(
                                gettext.t(
                                  'Address',
                                  null,
                                ),
                              ),
                            if (prefs.address.isNotEmpty)
                              pw.Text(
                                prefs.address,
                                textAlign: pw.TextAlign.right,
                              ),
                          ],
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
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          padding: EdgeInsets.zero,
          scrollViewDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          pdfFileName: "${context.t(
                'Invoice {0}',
                args: [
                  invoice.number,
                ],
              ).toLowerCase().replaceAll(' ', '_')}.pdf",
          build: (pageFormat) => snapshot.data!.save(),
        );
      },
    );
  }

  // ignore: long-method
  Iterable<pw.TableRow> _buildTable(
    List<List<Group<String, Service>>> pages,
    int page,
    Map<int, Child> childrenMap,
  ) sync* {
    const previousChildId = -1;
    for (final group in pages[page]) {
      yield pw.TableRow(
        decoration: const pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(color: PdfColors.grey),
          ),
        ),
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: pw.Text(
              group.key.formatDate(),
              textAlign: pw.TextAlign.left,
              style: const pw.TextStyle(fontSize: 14),
            ),
          ),
        ],
      );
      for (final service in group.value) {
        final newChild = service.childId != previousChildId;
        yield pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: pw.Text(
                state.children.length == 1
                    ? ''
                    : newChild
                        ? childrenMap[service.childId]!.firstName
                        : '',
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: pw.Text(
                service.priceLabel ?? 'Dummy service',
                textAlign: pw.TextAlign.left,
                style: const pw.TextStyle(fontSize: 14),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: pw.Text(
                service.isFixedPrice == 1
                    ? '-'
                    : '${service.hours}h'
                        "${service.minutes.toString().padLeft(2, '0')} x "
                        '${service.priceAmount!.toStringAsFixed(2)}',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 14),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: pw.Text(
                service.total.toStringAsFixed(2),
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(fontSize: 14),
              ),
            ),
          ],
        );
      }
    }
  }

  Future<File> _getLogoFile() async {
    final applicationDirectory = await getApplicationDocumentsDirectory();
    final appDocumentsPath = applicationDirectory.path;
    final filePath = '$appDocumentsPath/logo';
    final file = File(filePath);

    return file;
  }

  Future<pw.Font?> _getLine2Font(PrefsUtil prefs) async {
    final line2FontAsset = prefs.line2FontAsset;
    final byteData2 = line2FontAsset.isNotEmpty
        ? await rootBundle.load(prefs.line2FontAsset)
        : null;
    final line2Font = byteData2 != null ? pw.Font.ttf(byteData2) : null;

    return line2Font;
  }

  Future<pw.Font?> _getLine1Font(PrefsUtil prefs) async {
    final line1FontAsset = prefs.line1FontAsset;
    final byteData1 = line1FontAsset.isNotEmpty
        ? await rootBundle.load(line1FontAsset)
        : null;
    final line1Font = byteData1 != null ? pw.Font.ttf(byteData1) : null;

    return line1Font;
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

  pw.Widget invoiceTitle(List<Child> children) {
    var childName = children[0].displayName;
    if (children.length > 1) {
      childName =
          "${children.take(children.length - 1).map((child) => child.firstName).join(", ")} ${gettext.t("and", null)} ${children.last.firstName}";
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
                    childName,
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
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Text(
            gettext.t('Invoiced to', null),
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
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            gettext.t('Invoice number', null),
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
            gettext.t('Date', null),
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

  pw.Widget invoiceTable(Iterable<pw.TableRow> rows) {
    return pw.Column(
      children: [
        pw.Table(
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(),
                ),
              ),
              children: [
                blueText(gettext.t('Date', null)),
                blueText(gettext.t('Service', null)),
                blueText(
                  gettext.t('Hours', null),
                  textAlign: pw.TextAlign.center,
                ),
                blueText(
                  gettext.t('Price', null),
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

  pw.Column invoiceTotal(String conditions) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                "${gettext.t('Total incl. VAT', null)} : ",
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
}
