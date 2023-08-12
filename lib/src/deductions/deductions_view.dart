import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/deduction.dart';
import 'package:nannyplus/provider/deductions_provider.dart';
import 'package:nannyplus/src/deductions/deduction_card.dart';
import 'package:nannyplus/src/deductions/deduction_form.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/widgets/card_scroll_view.dart';
import 'package:nannyplus/widgets/floating_action_stack.dart';

class DeductionsView extends ConsumerWidget {
  const DeductionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deductions = ref.watch(deductionsProvider);

    return UIView(
      title: Text(context.t('Deductions')),
      persistentHeader: const UISliverCurvedPersistenHeader(),
      body: FloatingActionStack(
        child: deductions.when(
          data: (deductions) => CardScrollView(
            onReorder: (oldIndex, newIndex) {
              ref.read(deductionsProvider.notifier).reorder(oldIndex, newIndex);
            },
            bottomPadding: 80,
            children: deductions.map(DeductionCard.new).toList(),
          ),
          error: (_, __) => const Center(
            child: Text('Oops, an error has occured'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onPressed: () async {
          final deduction = await Navigator.of(context).push<Deduction?>(
            MaterialPageRoute<Deduction>(
              builder: (context) => const DeductionForm(),
              fullscreenDialog: true,
            ),
          );
          if (deduction != null) {
            ref.read(deductionsProvider.notifier).add(deduction);
          }
        },
      ),
    );
  }
}
