import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/utils/text_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
    Key? key,
  })  : _type = type,
        _date = date,
        super(key: key);

  final StatementViewType _type;
  final DateTime _date;

  @override
  Widget build(BuildContext context) {
    return UIView(
      title: Text(_type == StatementViewType.yearly
          ? context.t('Yearly statement')
          : context.t('Monthly statement')),
      persistentHeader: UISliverCurvedPersistenHeader(
        child: Text(_type == StatementViewType.yearly
            ? DateFormat('yyyy').format(_date)
            : DateFormat('MMMM yyyy').format(_date).capitalize()),
      ),
      body: _DocumentBuilder(_type, _date),
    );
  }
}

class _DocumentBuilder extends StatelessWidget {
  const _DocumentBuilder(
    StatementViewType type,
    DateTime date,
  )   : _type = type,
        _date = date;

  final StatementViewType _type;
  final DateTime _date;

  @override
  Widget build(BuildContext context) {
    final fileBase = "${context.t('Yearly statement')} $_date"
        .toLowerCase()
        .replaceAll(' ', '_');
    final fileName = "$fileBase.pdf";

    return FutureBuilder<pw.Document>(
      future: (() async {
        final pdf = pw.Document();
        if (_type == StatementViewType.yearly) {
          await _buildYearlyStatement(context, pdf);
        } else {
          await _buildMonthlyStatement(context, pdf);
        }

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

  Future<void> _buildYearlyStatement(
    BuildContext context,
    pw.Document doc,
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
          return pw.Stack(children: [
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
          ]);
        }),
      ),
    );
  }

  Future<void> _buildMonthlyStatement(
    BuildContext context,
    pw.Document doc,
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
          return pw.Stack(children: [
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
          ]);
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
}
