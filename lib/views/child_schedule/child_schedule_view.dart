import 'package:flex_color_picker/flex_color_picker.dart';
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
import 'package:nannyplus/views/child_schedule/schedule_color_provider.dart';
import 'package:nannyplus/widgets/time_input_dialog.dart';

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
    final scheduleColor = ref.watch(scheduleColorProvider(childId));

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
          data: (periods) => [
            UICard(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kdMediumPadding),
                  child: Row(
                    children: [
                      Text(
                        context.t('Color'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Text(' :'),
                      const SizedBox(width: kdMediumPadding),
                      Expanded(
                        child: ColorIndicator(
                          color: scheduleColor.valueOrNull ?? Colors.purple,
                          borderRadius: 4,
                          onSelectFocus: false,
                          onSelect: () async {
                            final selectedColor = await showColorPickerDialog(
                              context,
                              scheduleColor.valueOrNull ?? Colors.purple,
                              borderRadius: 4,
                              spacing: 2,
                              runSpacing: 2,
                              selectedPickerTypeColor:
                                  Theme.of(context).colorScheme.primary,
                              pickersEnabled: const <ColorPickerType, bool>{
                                ColorPickerType.both: true,
                                ColorPickerType.primary: false,
                                ColorPickerType.accent: false,
                                ColorPickerType.bw: false,
                                ColorPickerType.custom: false,
                                ColorPickerType.wheel: false,
                              },
                            );
                            await ref
                                .read(scheduleColorProvider(childId).notifier)
                                .updateColor(selectedColor);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ...periods.map((period) {
              return ScheduleEntry(
                period: period,
                updateTime: (from, time) =>
                    periodsNotifier.updateTime(period.id!, from, time),
                updateDay: (day) => periodsNotifier.updateDay(period.id!, day),
                delete: () => periodsNotifier.delete(period.id!),
                duplicate: () => periodsNotifier.duplicate(period.id!),
              );
            }).toList(),
          ],
          error: (_, __) => [Text('$_')],
          loading: () => [const Text('loading')],
        ),
      ),
    );
  }
}

class ScheduleEntry extends StatelessWidget {
  const ScheduleEntry({
    required this.period,
    required this.updateTime,
    required this.updateDay,
    required this.delete,
    this.duplicate,
    super.key,
  });

  final Period period;
  final void Function(bool from, TimeOfDay? time) updateTime;
  final void Function(String day) updateDay;
  final void Function() delete;
  final void Function()? duplicate;

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
                  const DropdownMenuItem<String>(
                    value: '',
                    child: Text('------'),
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
                  final time = await showDialog<TimeOfDay>(
                    context: context,
                    builder: (context) {
                      return TimeInputDialog(
                        initialTime: period.from,
                        hoursRange:
                            List.generate(13, (index) => index + 7).toList(),
                      );
                    },
                  );
                  if (time != null) {
                    updateTime(true, time);
                  }
                },
              ),
              Text(period.to.formatTimeOfDay()),
              IconButton(
                icon: const Icon(Icons.edit_calendar),
                onPressed: () async {
                  final time = await showDialog<TimeOfDay>(
                    context: context,
                    builder: (context) {
                      return TimeInputDialog(
                        initialTime: period.to,
                        hoursRange:
                            List.generate(13, (index) => index + 7).toList(),
                      );
                    },
                  );
                  if (time != null) {
                    updateTime(false, time);
                  }
                },
              ),
              const SizedBox(
                height: 24,
                child: VerticalDivider(
                  width: 0,
                ),
              ),
              if (duplicate != null)
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: duplicate,
                ),
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
