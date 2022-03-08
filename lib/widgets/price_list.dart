import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

class PriceList extends StatelessWidget {
  final List<Price> _prices;
  const PriceList(this._prices, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _prices.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final price = _prices[index];
        return ListTile(
          title: Text(price.label),
          subtitle: Text(
            context.t(
              price.isFixedPrice ? "Fixed price of {0}" : "Hourly price of {0}",
              args: [
                price.amount,
              ],
            ),
          ),
          leading: IconButton(
            icon: Icon(
              price.isFixedPrice ? Icons.looks_one : Icons.watch_later,
            ),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
