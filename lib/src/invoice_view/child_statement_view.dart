import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:nannyplus/cubit/child_info_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/date_format_extension.dart';
import 'package:nannyplus/utils/list_extensions.dart';
import 'package:nannyplus/utils/prefs_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ChildStatementView extends StatelessWidget {
  const ChildStatementView(
    this.group,
    this.gettext, {
    Key? key,
  }) : super(key: key);

  final Group<num, Invoice> group;
  final GettextLocalizations gettext;

  @override
  Widget build(BuildContext context) {
    return UIView(
      title: BlocBuilder<ChildInfoCubit, ChildInfoState>(
        builder: (context, state) => state is ChildInfoLoaded
            ? Text(state.child.displayName)
            : Text(context.t('Loading...')),
      ),
      persistentHeader: UISliverCurvedPersistenHeader(
        child: Text(
          context.t(
            'Statement for {0}',
            args: [
              group.key,
            ],
          ),
        ),
      ),
      body: BlocBuilder<ChildInfoCubit, ChildInfoState>(
        builder: (context, state) => state is ChildInfoLoaded
            ? _DocumentBuilder(state.child, group, gettext)
            : Text(context.t('Loading...')),
      ),
    );
  }
}

class _DocumentBuilder extends StatelessWidget {
  const _DocumentBuilder(
    this.child,
    this.group,
    this.gettext, {
    Key? key,
  }) : super(key: key);

  final Child child;
  final Group<num, Invoice> group;
  final GettextLocalizations gettext;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<pw.Document>(
      future: (() async {
        final prefs = await PrefsUtil.getInstance();
        final line1Font = await _getLine1Font(prefs);
        final line2Font = await _getLine2Font(prefs);

        final logoFile = await _getLogoFile();

        final doc = pw.Document()
          ..addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              margin: const pw.EdgeInsets.all(50),
              build: (context) {
                return pw.Stack(
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _statementHeader(
                          prefs.line1,
                          prefs.line2,
                          line1Font,
                          line2Font,
                        ),
                        _statementTitle(
                          '${child.displayName} - '
                          '${gettext.t('Yearly statement', null)} ${group.key}',
                        ),
                        _statementTable(_buildTable(group.value)),
                        _statementTotal(group),
                      ],
                    ),
                    if (logoFile.existsSync())
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
                  ],
                );
              },
            ),
          );

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
                'Statement {0}',
                args: [
                  group.key,
                ],
              ).toLowerCase().replaceAll(' ', '_')}.pdf",
          build: (pageFormat) => snapshot.data!.save(),
        );
      },
    );
  }

  // ignore: long-method
  Iterable<pw.TableRow> _buildTable(
    List<Invoice> invoices,
  ) sync* {
    for (final invoice in invoices) {
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
              invoice.date.formatDate(),
              textAlign: pw.TextAlign.left,
              style: const pw.TextStyle(fontSize: 14),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: pw.Text(
              invoice.total.toStringAsFixed(2),
              textAlign: pw.TextAlign.right,
              style: const pw.TextStyle(fontSize: 14),
            ),
          ),
        ],
      );
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

  pw.Widget _statementHeader(
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

  pw.Widget _statementTitle(String title) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Container(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8),
                  child: pw.Text(
                    title,
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

  pw.Widget _statementTable(Iterable<pw.TableRow> rows) {
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
                _blueText(gettext.t('Date', null)),
                _blueText(
                  gettext.t('Amount', null),
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

  pw.Widget _statementTotal(Group<num, Invoice> group) {
    final total = group.value.fold<double>(
      0,
      (previousValue, element) => previousValue + element.total,
    );

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.SizedBox(height: 70),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              gettext.t('Total : {0}', [total.toStringAsFixed(2)]),
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue,
              ),
              textAlign: pw.TextAlign.right,
            ),
          ],
        ),
      ],
    );
  }

  pw.Padding _blueText(String text, {pw.TextAlign? textAlign}) {
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
}
