import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/child_list_cubit.dart';
import '../data/model/child.dart';
import '../utils/snack_bar_util.dart';
import '../views/tab_view.dart';
import '../widgets/card_tile.dart';
import 'card_scroll_view.dart';

class ChildList extends StatelessWidget {
  const ChildList(
    this._children,
    this._pendingTotal,
    this.pendingTotalPerChild,
    this.undeletableChildren, {
    Key? key,
  }) : super(key: key);

  final List<Child> _children;
  final double _pendingTotal;
  final Map<int, double> pendingTotalPerChild;
  final List<int> undeletableChildren;

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
            isUndeletable: undeletableChildren.contains(child.id),
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
    required this.isUndeletable,
    Key? key,
  }) : super(key: key);

  final Child child;
  final double? pendingTotal;
  final bool isUndeletable;

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
      expandGestureDetector: false,
      trailing: Row(
        children: [
          Text(
            pendingTotal?.toStringAsFixed(2) ?? '0.00',
          ),
          IconButton(
            onPressed: isUndeletable
                ? () {
                    ScaffoldMessenger.of(context).failure(
                      context.t("There are existing services for this child"),
                    );
                  }
                : () async {
                    var delete = await _showConfirmationDialog(context);
                    if (delete ?? false) {
                      context.read<ChildListCubit>().delete(child);
                      ScaffoldMessenger.of(context).success(
                        context.t("Removed successfully"),
                      );
                    }
                  },
            icon: Icon(
              Icons.close,
              color: isUndeletable ? Colors.grey : Colors.red,
            ),
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
          content: Text(
            context.t('Are you sure you want to delete this child\'s folder ?'),
          ),
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
