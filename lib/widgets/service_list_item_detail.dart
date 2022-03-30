import 'package:flutter/material.dart';

import '../data/model/service.dart';

class ServiceListItemDetail extends StatelessWidget {
  const ServiceListItemDetail({
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(service.priceLabel!),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 2,
            child: Text(
              service.isFixedPrice! == 0 ? service.priceDetail : "",
              textAlign: TextAlign.end,
              style: const TextStyle(inherit: true),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: Text(
              service.total.toStringAsFixed(2),
              textAlign: TextAlign.end,
              textScaleFactor: 1.125,
            ),
          ),
        ],
      ),
    );
  }
}
