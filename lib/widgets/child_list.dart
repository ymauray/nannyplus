import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/child_list_cubit.dart';
import '../data/model/child.dart';
import '../utils/snack_bar_util.dart';
import '../views/tab_view.dart';

import 'card_scroll_view.dart';

class ChildList extends StatelessWidget {
  final List<Child> _children;
  final double _pendingTotal;
  final Map<int, double> pendingTotalPerChild;
  const ChildList(
    this._children,
    this._pendingTotal,
    this.pendingTotalPerChild, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardScrollView(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.t('Pending total'),
                style: const TextStyle(
                  inherit: true,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              _pendingTotal.toStringAsFixed(2),
              style: const TextStyle(
                inherit: true,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        ..._children.map(
          (child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(
                    Icons.phone,
                    color: child.hasPhoneNumber ? Colors.green : null,
                  ),
                  onPressed: () => child.hasPhoneNumber
                      ? launch('tel://${child.phoneNumber}')
                      : ScaffoldMessenger.of(context).failure(
                          context.t('No phone number'),
                        ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child.displayName,
                        style: child.isArchived
                            ? const TextStyle(
                                inherit: true,
                                fontStyle: FontStyle.italic,
                              )
                            : const TextStyle(
                                inherit: true,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                      child.hasAllergies
                          ? Text(
                              context.t(
                                "Allergies : {0}",
                                args: [child.allergies!],
                              ),
                            )
                          : Text(
                              context.t("No known allergies"),
                            ),
                    ],
                  ),
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TabView(child.id!),
                      ),
                    );
                    context.read<ChildListCubit>().loadChildList();
                  },
                ),
              ),
              Text(
                pendingTotalPerChild[child.id]?.toStringAsFixed(2) ?? '0.00',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
