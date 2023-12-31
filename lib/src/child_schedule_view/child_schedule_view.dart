import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/period.dart';
import 'package:nannyplus/provider/child_info_provider.dart';
import 'package:nannyplus/provider/periods_provider.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/time_of_day_extension.dart';

class ChildScheduleView extends ConsumerWidget {
  const ChildScheduleView({
    required this.childId,
    super.key,
  });

  final int childId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periods = ref.watch(periodsProvider(childId));
    final periodsNotifier = ref.watch(periodsProvider(childId).notifier);
    final child = ref.watch(childInfoProvider(childId));

    return UIView(
      title: Text(
        child.when(
          data: (child) => child.displayName,
          error: (_, __) => '',
          loading: () => '',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            await periodsNotifier.add();
          },
        ),
      ],
      persistentHeader: UISliverCurvedPersistenHeader(
        child: Text(context.t('Schedule')),
      ),
      body: UIListView.fromChildren(
        children: periods.when(
          data: (periods) => periods.map((period) {
            return ScheduleEntry(
              label: context.t(period.day),
              period: period,
              updateTime: (from, time) =>
                  periodsNotifier.updateTime(period.id!, from, time),
              updateDay: (day) => periodsNotifier.updateDay(period.id!, day),
              delete: () => periodsNotifier.delete(period.id!),
            );
          }).toList(),
          error: (_, __) => [Text('$_')],
          loading: () => [const Text('loading')],
        ),
      ),
    );
  }
}

class ScheduleEntry extends StatelessWidget {
  const ScheduleEntry({
    required this.label,
    required this.period,
    required this.updateTime,
    required this.updateDay,
    required this.delete,
    super.key,
  });

  final String label;
  final Period period;
  final void Function(bool from, TimeOfDay? time) updateTime;
  final void Function(String day) updateDay;
  final void Function() delete;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        Padding(
          padding: const EdgeInsets.all(kdMediumPadding),
          child: Row(
            children: [
              DropdownButton(
                value: period.day,
                items: [
                  DropdownMenuItem<String>(
                    value: '',
                    child: Text(context.t('------')),
                  ),
                  DropdownMenuItem<String>(
                    value: 'monday',
                    child: Text(context.t('Monday')),
                  ),
                  DropdownMenuItem<String>(
                    value: 'tuesday',
                    child: Text(context.t('Tuesday')),
                  ),
                  DropdownMenuItem<String>(
                    value: 'wednesday',
                    child: Text(context.t('Wednesday')),
                  ),
                  DropdownMenuItem<String>(
                    value: 'thursday',
                    child: Text(context.t('Thursday')),
                  ),
                  DropdownMenuItem<String>(
                    value: 'friday',
                    child: Text(context.t('Friday')),
                  ),
                ],
                onChanged: (value) {
                  updateDay(value!);
                },
              ),
              const Text(' : '),
              const Spacer(),
              Text(period.from.formatTimeOfDay()),
              IconButton(
                icon: const Icon(Icons.edit_calendar),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: period.from,
                  );
                  if (time != null) {
                    updateTime(true, time);
                  }
                },
              ),
              const SizedBox(width: kdMediumPadding),
              Text(period.to.formatTimeOfDay()),
              IconButton(
                icon: const Icon(Icons.edit_calendar),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: period.to,
                  );
                  if (time != null) {
                    updateTime(false, time);
                  }
                },
              ),
              const SizedBox(width: kdMediumPadding),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: delete,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
