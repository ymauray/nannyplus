import 'package:flutter/material.dart';
import 'package:nannyplus/cubit/child_list_cubit.dart';
import 'package:nannyplus/forms/child_form.dart';
import 'package:nannyplus/views/invoice_list_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/views/service_list_view.dart';

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
          title: Text(
            child.displayName,
            style: child.isArchived
                ? const TextStyle(fontStyle: FontStyle.italic)
                : null,
          ),
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ServiceListView(child))),
          subtitle: child.hasAllergies
              ? Text(child.allergies!)
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
              if (!child.isArchived)
                PopupMenuItem(
                  value: 'archive',
                  child: Text(context.t('Archive')),
                ),
              if (child.isArchived)
                PopupMenuItem(
                  value: 'unarchive',
                  child: Text(context.t('Unarchive')),
                ),
              const PopupMenuItem(
                height: 0,
                child: Divider(),
              ),
              PopupMenuItem(
                value: 'invoices',
                child: Text(context.t('Invoices')),
              ),
              // PopupMenuItem(
              //   value: 'delete',
              //   child: Text(context.t('Delete')),
              //   textStyle: const TextStyle(color: Colors.red),
              // ),
            ],
            onSelected: (value) async {
              if (value == 'edit') {
                var editedChild = await Navigator.of(context).push<Child>(
                  MaterialPageRoute(
                    builder: (context) => ChildForm(
                      child: child,
                    ),
                    fullscreenDialog: true,
                  ),
                );
                if (editedChild != null) {
                  context.read<ChildListCubit>().update(
                        editedChild.copyWith(
                          id: _children[index].id,
                        ),
                      );
                }
              } else if (value == 'archive') {
                context.read<ChildListCubit>().archive(child);
              } else if (value == 'unarchive') {
                context.read<ChildListCubit>().unarchive(child);
              } else if (value == 'invoices') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InvoiceListView(child),
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
