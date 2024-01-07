import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/common/loading_indicator.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/views/vacation_planning/vacation_period_card.dart';
import 'package:nannyplus/views/vacation_planning/vacation_planning_view_state_provider.dart';

class VacationPlanningView extends ConsumerWidget {
  const VacationPlanningView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(vacationPlanningViewStateProvider);
    final viewStateNotifier =
        ref.read(vacationPlanningViewStateProvider.notifier);

    var lastDay = '${viewState.valueOrNull?.year ?? DateTime.now().year}-01-01';

    return UIView(
      title: Text(context.t('Vacation planning')),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            await viewStateNotifier.addPeriod(lastDay);
          },
        ),
      ],
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
                    .read(vacationPlanningViewStateProvider.notifier)
                    .decrement();
              },
            ),
            TextButton(
              child: Text(
                viewState.valueOrNull?.year.toString() ?? '----',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              onPressed: () {
                ref.read(vacationPlanningViewStateProvider.notifier).reset();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                ref
                    .read(vacationPlanningViewStateProvider.notifier)
                    .increment();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: viewState.valueOrNull == null
            ? const Center(
                child: LoadingIndicator(),
              )
            : UIListView(
                itemBuilder: (context, index) {
                  final period = viewState.requireValue.periods[index];
                  if (period.start.compareTo(lastDay) > 0) {
                    lastDay = period.start;
                  }
                  if (period.end != null &&
                      period.end!.compareTo(lastDay) > 0) {
                    lastDay = period.end!;
                  }
                  return VacationPeriodCard(
                    index: index,
                    //duplicate: () async {
                    //  await viewStateNotifier.duplicatePeriod(period);
                    //},
                    delete: () async {
                      await viewStateNotifier.deletePeriod(period);
                    },
                  );
                },
                itemCount: viewState.valueOrNull?.periods.length ?? 0,
              ),
      ),
    );
  }
}
