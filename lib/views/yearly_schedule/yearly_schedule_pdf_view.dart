import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/schedule.dart';
import 'package:nannyplus/data/model/vacation_period.dart';
import 'package:nannyplus/provider/vacation_period_provider.dart';
import 'package:nannyplus/provider/weekly_schedule_provider.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/views/yearly_schedule/yearly_schedule_pdf_view_state_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class YearlySchedulePdfView extends ConsumerWidget {
  const YearlySchedulePdfView({super.key});

  static const rowHeight = 15.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = ref.watch(weeklyScheduleProvider).valueOrNull;
    final viewState = ref.watch(yearlySchedulePdfViewStateProvider);
    final startOfYear = DateTime(viewState.year);
    final vacationPeriods =
        ref.watch(vacationPeriodsProvider(viewState.year)).valueOrNull;

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
                          vacationPeriods,
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
      persistentHeader: UISliverCurvedPersistenHeader(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                ref
                    .read(yearlySchedulePdfViewStateProvider.notifier)
                    .decrement();
              },
            ),
            TextButton(
              child: Text(
                viewState.year.toString(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              onPressed: () {
                ref.read(yearlySchedulePdfViewStateProvider.notifier).reset();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                ref
                    .read(yearlySchedulePdfViewStateProvider.notifier)
                    .increment();
              },
            ),
          ],
        ),
      ),
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
    List<VacationPeriod>? vacationPeriods,
  ) {
    final monthName = context.t(DateFormat('MMMM').format(startOfMonth));
    final displayName = monthName.substring(0, 1).toUpperCase() +
        monthName.substring(1).toLowerCase();
    final endDate = DateTime(startOfMonth.year, startOfMonth.month + 1)
        .add(const Duration(microseconds: -1));
    final nGrams = schedule?.childIds.map((childId) {
          return pw.Expanded(
            child: pw.Center(
              child: pw.Text(
                schedule.childrenNames[childId] ?? '',
                style: const pw.TextStyle(fontSize: 5),
              ),
            ),
          );
        }).toList() ??
        <pw.Widget>[];

    return pw.Expanded(
      child: pw.Column(
        children: [
          monthNameCell(displayName),
          nGramsCell(nGrams),
          ...List.generate(
            endDate.day,
            (index) {
              final day =
                  DateTime(startOfMonth.year, startOfMonth.month, index + 1);
              final fmtDay = DateFormat('yyyy-MM-dd').format(day);
              final onVacation = vacationPeriods
                      ?.where(
                        (p) =>
                            (p.end == null && p.start == fmtDay) ||
                            (p.end != null &&
                                p.start.compareTo(fmtDay) <= 0 &&
                                p.end!.compareTo(fmtDay) >= 0),
                      )
                      .isNotEmpty ??
                  false;
              return dayCell(context, day, schedule, onVacation);
            },
          ),
        ],
      ),
    );
  }

  pw.Widget dayCell(
    BuildContext context,
    DateTime date,
    Schedule? schedule,
    bool onVacation,
  ) {
    if (schedule == null) return pw.Container();

    final dayLabel = context
        .t(
          DateFormat('EEEE').format(date),
        )
        .toUpperCase()
        .substring(0, 1);

    final dayKey = DateFormat.EEEE('en').format(date);

    final periods = schedule.periodsByDay(dayKey.toLowerCase());

    final itemPeriods = periods;

    final colorIndicators = schedule.childIds.map((childId) {
      final morningPeriod = itemPeriods
          .where(
            (period) => period.childId == childId && period.isMorning,
          )
          .firstOrNull;
      final afternoonPeriod = itemPeriods
          .where(
            (period) => period.childId == childId && !period.isMorning,
          )
          .firstOrNull;

      return pw.Expanded(
        child: pw.Column(
          children: [
            pw.Expanded(
              child: pw.Container(
                color: morningPeriod != null
                    ? PdfColor.fromInt(
                        schedule.scheduleColors
                            .where(
                              (scheduleColor) =>
                                  scheduleColor.childId == childId,
                            )
                            .first
                            .color,
                      )
                    : const PdfColor(1, 1, 1),
              ),
            ),
            pw.Expanded(
              child: pw.Container(
                color: afternoonPeriod != null
                    ? PdfColor.fromInt(
                        schedule.scheduleColors
                            .where(
                              (scheduleColor) =>
                                  scheduleColor.childId == childId,
                            )
                            .first
                            .color,
                      )
                    : const PdfColor(1, 1, 1),
              ),
            ),
          ],
        ),
      );
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
              child: onVacation
                  ? pw.Center(
                      child: pw.Container(
                        decoration:
                            const pw.BoxDecoration(color: PdfColors.grey500),
                      ),
                    )
                  : date.weekday >= 6
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

  pw.Widget nGramsCell(List<pw.Widget> nGrams) {
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
          ),
          pw.Container(
            height: rowHeight,
            width: rowHeight * .75,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              height: rowHeight,
              width: rowHeight,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Row(
                children: nGrams,
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
