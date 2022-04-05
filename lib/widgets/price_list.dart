import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../data/model/price.dart';
import '../cubit/price_list_cubit.dart';
import '../forms/price_form.dart';
import '../widgets/card_scroll_view.dart';
import '../widgets/floating_action_stack.dart';
import 'card_tile.dart';

class PriceList extends StatelessWidget {
  const PriceList(this._prices, this._inUse, {Key? key}) : super(key: key);

  final List<Price> _prices;
  final Set<int> _inUse;

  @override
  Widget build(BuildContext context) {
    return FloatingActionStack(
      child: CardScrollView(
        onReorder: (oldIndex, newIndex) {
          context.read<PriceListCubit>().reorder(oldIndex, newIndex);
        },
        bottomPadding: 80,
        children: _prices
            .map((price) => _PriceCard(price, _inUse.contains(price.id)))
            .toList(),
      ),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<Price>(
            builder: (context) => const PriceForm(),
            fullscreenDialog: true,
          ),
        );
        context.read<PriceListCubit>().getPriceList();
      },
    );
  }
}

class _PriceCard extends StatelessWidget {
  const _PriceCard(this.price, this.inUse, {Key? key}) : super(key: key);

  final Price price;
  final bool inUse;

  @override
  Widget build(BuildContext context) {
    return CardTile(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PriceForm(price: price),
          fullscreenDialog: true,
        ));
      },
      title: Text(
        price.label,
        style: const TextStyle(
          inherit: true,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        context.t(
          price.isFixedPrice ? "Fixed price of {0}" : "Hourly price of {0}",
          args: [price.amount.toStringAsFixed(2)],
        ),
        style: Theme.of(context).textTheme.caption,
      ),
      trailing: Row(
        children: [
          if (!inUse)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () async {
                var delete = await _showConfirmationDialog(context);
                if (delete ?? false) {
                  await context.read<PriceListCubit>().delete(price.id!);
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
          content:
              Text(context.t('Are you sure you want to delete this price ?')),
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
