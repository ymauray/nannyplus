import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/period.dart';
import 'package:nannyplus/provider/children.dart';
import 'package:nannyplus/provider/weekly_schedule_provider.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/list_extensions.dart';
import 'package:nannyplus/utils/time_of_day_extension.dart';
import 'package:nannyplus/views/weekly_schedule/weekly_schedule_view_state_provider.dart';

class WeeklyScheduleView extends ConsumerWidget {
  const WeeklyScheduleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weeklyScheduleViewStateProvider);
    final stateNotifier = ref.read(weeklyScheduleViewStateProvider.notifier);
    final schedule = ref.watch(weeklyScheduleProvider).valueOrNull;
    final periods = schedule?.periodsByDay(state.day) ?? <Period>[];
    final children = ref.watch(childListProvider(null));

    return UIView(
      title: Text(context.t('Weekly schedule')),
      persistentHeader: UISliverCurvedPersistenHeader(
        child: Row(
          children: [
            IconButton(
              onPressed: stateNotifier.previousDay,
              icon: Icon(
                Icons.chevron_left,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(
              width: 128,
              child: Center(child: Text(context.t(state.day))),
            ),
            IconButton(
              onPressed: stateNotifier.nextDay,
              icon: Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            final nGrams = schedule?.childIds.map((childId) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        schedule.childrenNames[childId] ?? '',
                      ),
                    ),
                  );
                }).toList() ??
                <Widget>[];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 64,
                    child: Center(
                      child: Container(),
                    ),
                  ),
                  ...nGrams.separateWith(
                    (index) => const SizedBox(
                      height: 16,
                      child: VerticalDivider(
                        width: 8,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          // index 0 is 7:00, then each index is 15 minutes
          final minute = (index - 1) * 15;
          final hour = 7 + minute ~/ 60;
          final time = TimeOfDay(hour: hour, minute: minute % 60);
          final itemPeriods = periods.where((period) {
            final startMinute = period.from.hour * 60 + period.from.minute;
            final endMinute = period.to.hour * 60 + period.to.minute;
            final periodStart = 7 * 60 + minute;
            return startMinute <= periodStart && periodStart < endMinute;
          }).toList();
          final colorIndicators = schedule?.childIds.map((childId) {
                final period = itemPeriods
                    .where(
                      (period) => period.childId == childId,
                    )
                    .firstOrNull;
                if (period != null) {
                  return Expanded(
                    child: ColorIndicator(
                      color: Color(
                        schedule.scheduleColors
                            .where(
                              (scheduleColor) =>
                                  scheduleColor.childId == childId,
                            )
                            .first
                            .color,
                      ),
                      borderRadius: 0,
                    ),
                  );
                } else {
                  return const Expanded(
                    child: ColorIndicator(
                      color: Colors.transparent,
                      borderRadius: 0,
                    ),
                  );
                }
              }).toList() ??
              <ColorIndicator>[];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 64,
                  child: Center(
                    child: Text(
                      time.formatTimeOfDay(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                ...colorIndicators
                    .separateWith((index) => const SizedBox(width: 8)),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 0,
        ),
        itemCount: 1 + 12 * 4,
      ),
    );
  }
}
