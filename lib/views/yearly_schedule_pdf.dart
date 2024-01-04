import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/schedule.dart';
import 'package:nannyplus/provider/weekly_schedule_provider.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class YearlySchedulePdf extends ConsumerWidget {
  const YearlySchedulePdf({super.key});

  static const rowHeight = 15.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startOfYear = DateTime(DateTime.now().year);
    final schedule = ref.watch(weeklyScheduleProvider).valueOrNull;

    final doc = pw.Document()
      ..addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(16),
          build: ((ctx) {
            return pw.Column(
              children: [
                pw.Text(
                  '${startOfYear.year}',
                  style: const pw.TextStyle(fontSize: 24),
                ),
                pw.SizedBox(height: rowHeight),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: List.generate(12, (index) => index + 1)
                      .map<pw.Widget>(
                        (month) => monthColumnBuilder(
                          context,
                          DateTime(startOfYear.year, month),
                          schedule,
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          }),
        ),
      );

    return UIView(
      title: Text(context.t('Yearly schedule')),
      persistentHeader: const UISliverCurvedPersistenHeader(),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        padding: EdgeInsets.zero,
        scrollViewDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        pdfFileName: 'yearly_schedule.pdf',
        build: (pageFormat) => doc.save(),
      ),
    );
  }

  pw.Widget monthColumnBuilder(
    BuildContext context,
    DateTime startOfMonth,
    Schedule? schedule,
  ) {
    final monthName = DateFormat('MMMM').format(startOfMonth);
    final displayName = monthName.substring(0, 1).toUpperCase() +
        monthName.substring(1).toLowerCase();
    final endDate = DateTime(startOfMonth.year, startOfMonth.month + 1)
        .add(const Duration(microseconds: -1));
    return pw.Expanded(
      child: pw.Column(
        children: [
          monthNameCell(displayName),
          ...List.generate(
            endDate.day,
            (index) => dayCell(
              DateTime(
                startOfMonth.year,
                startOfMonth.month,
                index + 1,
              ),
              schedule,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget dayCell(DateTime date, Schedule? schedule) {
    if (schedule == null) return pw.Container();

    final dayLabel =
        DateFormat('EEEE').format(date).toUpperCase().substring(0, 1);

    final dayKey = DateFormat.EEEE('en').format(date);

    final periods = schedule.periodsByDay(dayKey.toLowerCase());

    final itemPeriods = periods;

    final colorIndicators = schedule.childIds.map((childId) {
      final period = itemPeriods
          .where(
            (period) => period.childId == childId,
          )
          .firstOrNull;
      if (period != null) {
        return pw.Expanded(
          child: pw.Container(
            color: PdfColor.fromInt(
              schedule.scheduleColors
                  .where(
                    (scheduleColor) => scheduleColor.childId == childId,
                  )
                  .first
                  .color,
            ),
          ),
        );
      } else {
        return pw.Expanded(
          child: pw.Container(
            color: const PdfColor(1, 1, 1),
          ),
        );
      }
    }).toList();

    return pw.SizedBox(
      height: rowHeight,
      child: pw.Row(
        children: [
          pw.Container(
            height: rowHeight,
            width: rowHeight,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
              color: PdfColors.grey300,
            ),
            child: pw.Center(
              child: pw.Text(
                '${date.day}',
                style: const pw.TextStyle(fontSize: 9),
              ),
            ),
          ),
          pw.Container(
            height: rowHeight,
            width: rowHeight * .75,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
              color: date.weekday >= 6 ? PdfColors.grey300 : PdfColors.white,
            ),
            child: pw.Center(
              child: pw.Text(
                dayLabel,
                style: const pw.TextStyle(fontSize: 9),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              height: rowHeight,
              width: rowHeight,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                color: date.weekday >= 6 ? PdfColors.grey300 : PdfColors.white,
              ),
              child: date.weekday >= 6
                  ? pw.Center(child: pw.Text(''))
                  : pw.Row(
                      children: colorIndicators,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget monthNameCell(String monthName) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
        color: PdfColors.grey,
      ),
      child: pw.Center(
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            monthName,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 9,
            ),
          ),
        ),
      ),
    );
  }
}