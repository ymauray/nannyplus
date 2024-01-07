import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/period.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/utils/time_of_day_extension.dart';
import 'package:nannyplus/widgets/time_input_dialog.dart';

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
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.access_time),
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
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.access_time),
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
                  width: 12,
                ),
              ),
              if (duplicate != null)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.copy),
                  onPressed: duplicate,
                ),
              IconButton(
                visualDensity: VisualDensity.compact,
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
