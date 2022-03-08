import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/prestation.dart';

class PrestationListItemDetail extends StatelessWidget {
  const PrestationListItemDetail({
    Key? key,
    required this.prestation,
  }) : super(key: key);

  final Prestation prestation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(prestation.priceLabel!),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: Text(
              prestation.hours != null
                  ? "${prestation.hours}h${prestation.minutes!.toString().padLeft(2, '0')}"
                  : "",
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: Text(
              prestation.price.toStringAsFixed(2),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
