import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/model/child.dart';
import '../utils/date_format_extension.dart';
import '../widgets/card_scroll_view.dart';

class ChildInfo extends StatelessWidget {
  const ChildInfo(
    this.child, {
    Key? key,
  }) : super(key: key);

  final Child child;

  @override
  Widget build(BuildContext context) {
    return CardScrollView(
      bottomPadding: 8,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                context.t('Birthdate'),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Row(
              children: [
                Expanded(child: Text(child.birthdate?.formatDate() ?? '')),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                context.t('Allergies'),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    child.allergies ?? context.t('No known allergies'),
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                context.t('Parents name'),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Row(
              children: [
                Expanded(child: Text(child.parentsName ?? '')),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                context.t('Address'),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Row(
              children: [
                Expanded(child: Text(child.address ?? '')),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                context.t('Phone number'),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Row(
              children: [
                Expanded(child: Text(child.phoneNumber ?? '')),
                if (child.hasPhoneNumber)
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => launch('tel://${child.phoneNumber}'),
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          ],
        ),
        if ((child.labelForPhoneNumber2?.isNotEmpty ?? false) &&
            (child.phoneNumber2?.isNotEmpty ?? false))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  child.labelForPhoneNumber2!,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text(child.phoneNumber2!)),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => launch('tel://${child.phoneNumber2}'),
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        if ((child.labelForPhoneNumber3?.isNotEmpty ?? false) &&
            (child.phoneNumber3?.isNotEmpty ?? false))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  child.labelForPhoneNumber3!,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text(child.phoneNumber3!)),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => launch('tel://${child.phoneNumber3}'),
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
