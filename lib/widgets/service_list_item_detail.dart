import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/service.dart';

class ServiceListItemDetail extends StatelessWidget {
  const ServiceListItemDetail({
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(service.priceLabel!),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: Text(
              service.isFixedPrice! == 0
                  ? "${service.hours}h${service.minutes!.toString().padLeft(2, '0')}"
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
              service.total.toStringAsFixed(2),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
