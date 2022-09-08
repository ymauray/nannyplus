import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/statement.dart';
import 'package:nannyplus/utils/text_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../cubit/statement_view_cubit.dart';
import '../../utils/prefs_util.dart';
import '../ui/sliver_curved_persistent_header.dart';
import '../ui/view.dart';

enum StatementViewType {
  yearly,
  monthly,
}

class StatementView extends StatelessWidget {
  const StatementView({
    required StatementViewType type,
    required DateTime date,
    required GettextLocalizations gettext,
    Key? key,
  })  : _type = type,
        _date = date,
        _gettext = gettext,
        super(key: key);

  final StatementViewType _type;
  final DateTime _date;
  final GettextLocalizations _gettext;

  @override
  Widget build(BuildContext context) {
    context.read<StatementViewCubit>().loadStatement(_type, _date);

    return BlocBuilder<StatementViewCubit, StatementViewState>(
      builder: ((context, state) {
        return UIView(
          title: Text(_type == StatementViewType.yearly
              ? context.t('Yearly statement')
              : context.t('Monthly statement')),
          persistentHeader: UISliverCurvedPersistenHeader(
            child: Text(_type == StatementViewType.yearly
                ? DateFormat('yyyy').format(_date)
                : DateFormat('MMMM yyyy').format(_date).capitalize()),
          ),
          body: Builder(builder: (context) {
            if (state is StatementViewGenerating) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StatementViewLoaded) {
              return _DocumentBuilder(_type, _date, state.statement, _gettext);
            } else {
              return Center(
                child: Text(context.t('No data')),
              );
            }
          }),
        );
      }),
    );
  }
}

class _DocumentBuilder extends StatelessWidget {
  const _DocumentBuilder(
    StatementViewType type,
    DateTime date,
    Statement statement,
    GettextLocalizations gettext,
  )   : _type = type,
        _date = date,
        _statement = statement,
        _gettext = gettext;

  final StatementViewType _type;
  final DateTime _date;
  final Statement _statement;
  final GettextLocalizations _gettext;

  @override
  Widget build(BuildContext context) {
    final title = _type == StatementViewType.yearly
        ? "${context.t('Yearly statement')} ${_date.year}"
        : "${context.t('Monthly statement')} ${DateFormat('yyyy MM').format(_date)}";
    final fileBase = title.toLowerCase().replaceAll(' ', '_');
    final fileName = "$fileBase.pdf";

    return FutureBuilder<pw.Document>(
      future: (() async {
        final pdf = pw.Document();
        await _buildStatement(context, pdf, _statement);

        return pdf;
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
          pdfFileName: fileName,
          build: (pageFormat) => snapshot.data!.save(),
        );
      },
    );
  }

  Future<void> _buildStatement(
    BuildContext context,
    pw.Document doc,
    Statement statement,
  ) async {
    var prefs = await PrefsUtil.getInstance();
    pw.Font? line1Font = await _getLine1Font(prefs);
    pw.Font? line2Font = await _getLine2Font(prefs);

    File logoFile = await _getLogoFile();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(50),
        build: ((context) {
          return pw.Stack(
            children: [
              pw.Column(
                children: [
                  statementHeader(
                    _date,
                    prefs.line1,
                    prefs.line2,
                    line1Font,
                    line2Font,
                  ),
                  statementTitle(_date, _type),
                  statementMeta(prefs.name, prefs.address),
                  statementTable(statement),
                  statementTotal(statement),
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
                    fit: pw.BoxFit.contain,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Future<pw.Font?> _getLine1Font(PrefsUtil prefs) async {
    var line1FontAsset = prefs.line1FontAsset;
    final byteData1 = line1FontAsset.isNotEmpty
        ? await rootBundle.load(line1FontAsset)
        : null;
    final line1Font = byteData1 != null ? pw.Font.ttf(byteData1) : null;

    return line1Font;
  }

  Future<pw.Font?> _getLine2Font(PrefsUtil prefs) async {
    var line2FontAsset = prefs.line2FontAsset;
    final byteData2 = line2FontAsset.isNotEmpty
        ? await rootBundle.load(prefs.line2FontAsset)
        : null;
    final line2Font = byteData2 != null ? pw.Font.ttf(byteData2) : null;

    return line2Font;
  }

  Future<File> _getLogoFile() async {
    final applicationDirectory = await getApplicationDocumentsDirectory();
    final appDocumentsPath = applicationDirectory.path;
    final filePath = '$appDocumentsPath/logo';
    final file = File(filePath);

    return file;
  }

  // ignore: long-method, long-parameter-list
  pw.Widget statementHeader(
    DateTime date,
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

  pw.Widget statementTitle(DateTime date, StatementViewType type) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Container(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 8),
                  child: pw.Text(
                    type == StatementViewType.monthly
                        ? "${_gettext.t('Monthly statement', null)} ${DateFormat('MMMM yyyy').format(_date).capitalize()}"
                        : "${_gettext.t('Yearly statement', null)} ${_date.year}",
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

  pw.Widget statementMeta(String name, String address) {
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
                  pw.Text(name, style: const pw.TextStyle(fontSize: 14)),
                  pw.Text(
                    address,
                    style: const pw.TextStyle(
                      inherit: true,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 18),
      ],
    );
  }

  pw.Widget statementTable(Statement statement) {
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
                blueText(
                  _gettext.t('Service', []),
                ),
                blueText(
                  _gettext.t('Price', []),
                  textAlign: pw.TextAlign.right,
                ),
                blueText(
                  _gettext.t('Quantity', []),
                  textAlign: pw.TextAlign.center,
                ),
                blueText(
                  _gettext.t('Amount', []),
                  textAlign: pw.TextAlign.right,
                ),
              ],
            ),
            ...statementRows(statement),
          ],
        ),
        //pw.SizedBox(height: 28),
      ],
    );
  }

  // ignore: long-method
  Iterable<pw.TableRow> statementRows(Statement statement) sync* {
    for (final line in statement.lines) {
      yield pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text(
              line.priceLabel,
              style: const pw.TextStyle(fontSize: 14),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text(
              line.priceAmount.toStringAsFixed(2),
              style: const pw.TextStyle(fontSize: 14),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text(
              line.isFixedPrice == 0
                  ? "${line.hours}.${line.minutes}"
                  : line.count.toString(),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text(
              line.total.toStringAsFixed(2),
              textAlign: pw.TextAlign.right,
              style: const pw.TextStyle(fontSize: 14),
            ),
          ),
        ],
      );
    }
  }

  pw.Widget statementTotal(Statement statement) {
    final total = statement.lines
        .fold<double>(0.0, (previousValue, line) => previousValue + line.total);

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.SizedBox(height: 70),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              _gettext.t('Total : {0}', [total.toStringAsFixed(2)]),
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

  pw.Widget blueText(String text, {pw.TextAlign? textAlign}) {
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
