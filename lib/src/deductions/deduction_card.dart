import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/deduction.dart';
import 'package:nannyplus/provider/deductions_provider.dart';
import 'package:nannyplus/widgets/card_tile.dart';

class DeductionCard extends ConsumerWidget {
  const DeductionCard(this.deduction, {super.key});

  final Deduction deduction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var subtitle = deduction.periodicity == 'monthly'
        ? context.t('Monthly')
        : context.t('Yearly');
    subtitle += ', ${deduction.value.toStringAsFixed(2)}';
    subtitle += deduction.type == 'percent' ? '%' : '';

    return CardTile(
      onTap: () async {},
      title: Text(
        deduction.label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
            onPressed: () async {
              final delete = await _showConfirmationDialog(context);
              if (delete ?? false) {
                await ref.read(deductionsProvider.notifier).remove(deduction);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Delete')),
          content: Text(
              context.t('Are you sure you want to delete this deduction ?')),
          actions: [
            TextButton(
              child: Text(context.t('Yes')),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text(context.t('No')),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
