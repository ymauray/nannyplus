import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/widgets/card_tile.dart';
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
      bottomPadding: 80,
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
              key: const ValueKey("pending_total"),
              style: const TextStyle(
                inherit: true,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        ..._children.map(
          (child) => _ChildCard(
            child: child,
            pendingTotal: pendingTotalPerChild[child.id],
          ),
        ),
      ],
    );
  }
}

class _ChildCard extends StatelessWidget {
  const _ChildCard({
    required this.child,
    required this.pendingTotal,
    Key? key,
  }) : super(key: key);

  final Child child;
  final double? pendingTotal;

  @override
  Widget build(BuildContext context) {
    return CardTile(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TabView(child.id!),
          ),
        );
        context.read<ChildListCubit>().loadChildList();
      },
      leading: IconButton(
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
      title: Text(
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
      subtitle: child.hasAllergies
          ? Text(
              context.t(
                "Allergies : {0}",
                args: [child.allergies!],
              ),
            )
          : Text(
              context.t("No known allergies"),
            ),
      trailing: Text(
        pendingTotal?.toStringAsFixed(2) ?? '0.00',
      ),
    );
  }
}
