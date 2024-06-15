import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/views/vacation_planning/vacation_planning_view_state_provider.dart';

class VacationPeriodCard extends ConsumerWidget {
  VacationPeriodCard({
    required this.index,
    required this.delete,
    this.duplicate,
    super.key,
  });

  final int index;
  final void Function() delete;
  final void Function()? duplicate;

  final longDateFormat = DateFormat('E d MMM yyyy');
  final shortDateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(vacationPlanningViewStateProvider);
    final viewStateNotifier =
        ref.read(vacationPlanningViewStateProvider.notifier);

    final period = viewState.requireValue.periods[index];

    return UICard(
      children: [
        Padding(
          padding: const EdgeInsets.all(kdMediumPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    (period.end != null ? "${context.t('from.date')} : " : '') +
                        longDateFormat.format(
                          shortDateFormat.parse(
                            period.start,
                          ),
                        ),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: shortDateFormat.parse(period.start),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 10),
                      );
                      if (selectedDate != null) {
                        await viewStateNotifier.setPeriodStart(
                          index,
                          shortDateFormat.format(selectedDate),
                        );
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      width: 0,
                    ),
                  ),
                  Switch(
                    value: period.end != null,
                    onChanged: (value) async {
                      await viewStateNotifier.setPeriodEnd(
                        index,
                        value ? period.start : null,
                      );
                    },
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
              if (period.end != null)
                Row(
                  children: [
                    Text(
                      '${context.t('to.date')} : ${longDateFormat.format(
                        shortDateFormat.parse(period.end!),
                      )}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: shortDateFormat.parse(period.end!),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (selectedDate != null) {
                          await viewStateNotifier.setPeriodEnd(
                            index,
                            shortDateFormat.format(selectedDate),
                          );
                        }
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
