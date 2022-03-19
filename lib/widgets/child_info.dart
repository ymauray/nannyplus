import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../data/model/child.dart';
import '../utils/date_format_extension.dart';
import '../widgets/card_scroll_view.dart';

class ChildInfo extends StatelessWidget {
  final Child child;
  const ChildInfo(
    this.child, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardScrollView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(context.t('Birthdate'),
                  style: Theme.of(context).textTheme.caption),
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
              child: Text(context.t('Allergies'),
                  style: Theme.of(context).textTheme.caption),
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
              child: Text(context.t('Parents name'),
                  style: Theme.of(context).textTheme.caption),
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
              child: Text(context.t('Address'),
                  style: Theme.of(context).textTheme.caption),
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
              child: Text(context.t('Phone number'),
                  style: Theme.of(context).textTheme.caption),
            ),
            Row(
              children: [
                Expanded(child: Text(child.phoneNumber ?? '')),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
