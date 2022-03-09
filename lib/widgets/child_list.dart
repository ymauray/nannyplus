import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/views/prestations_list_view.dart';

class ChildList extends StatelessWidget {
  final List<Child> _children;
  const ChildList(this._children, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _children.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final child = _children[index];
        return ListTile(
          title: Text(child.displayName),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => PrestationListView(child))),
          subtitle: child.hasAllergies
              ? Text(child.alergies!)
              : Text(context.t("No known allergies")),
          leading: IconButton(
            icon: const Icon(
              Icons.phone,
            ),
            onPressed: () => child.hasPhoneNumber
                ? launch('tel://${child.phoneNumber}')
                : ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.t('No phone number')),
                    ),
                  ),
          ),
          iconColor: child.hasPhoneNumber ? Colors.green : null,
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Text(context.t('Edit')),
              ),
              const PopupMenuItem(
                height: 0,
                child: Divider(),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(context.t('Delete')),
                textStyle: const TextStyle(color: Colors.red),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
              } else if (value == 'delete') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.t('Not implemented')),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}