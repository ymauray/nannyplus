import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/schedule.dart';
import 'package:nannyplus/provider/weekly_schedule_provider.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/list_extensions.dart';
import 'package:nannyplus/utils/time_of_day_extension.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class WeeklySchedulePdf extends ConsumerWidget {
  const WeeklySchedulePdf({super.key});
  static const weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  static const rowHeight = 38.0;
  static const hourColumnWidth = 64.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = ref.watch(weeklyScheduleProvider).valueOrNull;
    final nGrams = schedule?.childIds.map((childId) {
          return pw.Expanded(
            child: pw.Center(
              child: pw.Text(
                schedule.childrenNames[childId] ?? '',
              ),
            ),
          );
        }).toList() ??
        <pw.Widget>[];

    final doc = pw.Document()
      ..addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(16),
          build: ((ctx) {
            return pw.Column(
              children: [
                pw.Center(
                  child: pw.Text(
                    context.t('Weekly schedule'),
                  ),
                ),
                pw.SizedBox(height: rowHeight),
                _header(context),
                _subHeader(nGrams),
                if (schedule != null)
                  pw.ListView.separated(
                    itemBuilder: (ctx, index) {
                      final hour = 7 + index;
                      final time = TimeOfDay(hour: hour, minute: 0);

                      return _hourRow(
                        context,
                        time,
                        schedule,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return pw.Divider(height: 0);
                    },
                    itemCount: 12,
                  ),
              ],
            );
          }),
        ),
      );

    return UIView(
      title: Text(context.t('Weekly schedule')),
      persistentHeader: const UISliverCurvedPersistenHeader(),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        padding: EdgeInsets.zero,
        scrollViewDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        pdfFileName: 'schedule.pdf',
        build: (pageFormat) => doc.save(),
      ),
    );
  }

  pw.Widget _header(BuildContext context) {
    return pw.SizedBox(
      height: rowHeight / 2,
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: hourColumnWidth,
          ),
          pw.VerticalDivider(width: 0),
          ...weekDays
              .map<pw.Widget>(
                (e) =>
                    pw.Expanded(child: pw.Center(child: pw.Text(context.t(e)))),
              )
              .toList()
              .separateWith((index) => pw.VerticalDivider(width: 0)),
          pw.VerticalDivider(width: 0),
        ],
      ),
    );
  }

  pw.Widget _subHeader(List<pw.Widget> nGrams) {
    return pw.SizedBox(
      height: rowHeight / 2,
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: hourColumnWidth,
          ),
          pw.VerticalDivider(width: 0),
          ...weekDays
              .map<pw.Widget>(
                (day) => pw.Expanded(child: pw.Row(children: nGrams)),
              )
              .toList()
              .separateWith((index) => pw.VerticalDivider(width: 0)),
          pw.VerticalDivider(width: 0),
        ],
      ),
    );
  }

  pw.Widget _hourRow(BuildContext context, TimeOfDay time, Schedule schedule) {
    return pw.SizedBox(
      height: rowHeight,
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: hourColumnWidth,
            child: pw.Center(
              child: pw.Text(
                time.formatTimeOfDay(),
              ),
            ),
          ),
          pw.VerticalDivider(width: 0),
          ...weekDays
              .map<pw.Widget>(
                (day) => pw.Expanded(
                  child: pw.Column(
                    children: [
                      timeSlot(day, time.hour, 0, schedule),
                      timeSlot(day, time.hour, 15, schedule),
                      timeSlot(day, time.hour, 30, schedule),
                      timeSlot(day, time.hour, 45, schedule),
                    ],
                  ),
                ),
              )
              .toList()
              .separateWith((index) => pw.VerticalDivider(width: 0)),
          pw.VerticalDivider(width: 0),
        ],
      ),
    );
  }

  pw.Widget timeSlot(String day, int hour, int minute, Schedule schedule) {
    final periods = schedule.periodsByDay(day);

    final itemPeriods = periods.where((period) {
      final startMinute = period.from.hour * 60 + period.from.minute;
      final endMinute = period.to.hour * 60 + period.to.minute;
      final periodStart = hour * 60 + minute;
      return startMinute <= periodStart && periodStart < endMinute;
    }).toList();

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

    return pw.Expanded(
      child: pw.Row(
        children: colorIndicators,
      ),
    );
  }
}
