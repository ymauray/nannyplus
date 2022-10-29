import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/price_list_cubit.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/forms/price_form.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';
import 'package:nannyplus/widgets/card_scroll_view.dart';
import 'package:nannyplus/widgets/card_tile.dart';
import 'package:nannyplus/widgets/floating_action_stack.dart';
import 'package:nannyplus/widgets/loading_indicator.dart';

class PriceListView extends StatelessWidget {
  const PriceListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PriceListCubit>().getPriceList();

    return BlocConsumer<PriceListCubit, PriceListState>(
      listener: (context, state) async {
        if (state is PriceListError) {
          ScaffoldMessenger.of(context).failure(state.message);
        }
      },
      builder: (context, state) {
        return UIView(
          title: Text(context.t('Price list')),
          persistentHeader: const UISliverCurvedPersistenHeader(),
          body: (state is PriceListLoaded)
              ? FloatingActionStack(
                  child: CardScrollView(
                    onReorder: (oldIndex, newIndex) {
                      context
                          .read<PriceListCubit>()
                          .reorder(oldIndex, newIndex);
                    },
                    bottomPadding: 80,
                    children: state.priceList
                        .map((price) => _PriceCard(price))
                        .toList(),
                  ),
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute<Price>(
                        builder: (context) => const PriceForm(),
                        fullscreenDialog: true,
                      ),
                    );
                    await context.read<PriceListCubit>().getPriceList();
                  },
                )
              : const LoadingIndicator(),
        );
      },
    );
  }
}

class _PriceCard extends StatelessWidget {
  const _PriceCard(this.price, {Key? key}) : super(key: key);

  final Price price;

  @override
  Widget build(BuildContext context) {
    return CardTile(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => PriceForm(price: price),
            fullscreenDialog: true,
          ),
        );
      },
      title: Text(
        price.label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        context.t(
          price.isFixedPrice ? 'Fixed price of {0}' : 'Hourly price of {0}',
          args: [price.amount.toStringAsFixed(2)],
        ),
        style: Theme.of(context).textTheme.caption,
      ),
      trailing: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
            onPressed: () async {
              final delete = await _showConfirmationDialog(context);
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
