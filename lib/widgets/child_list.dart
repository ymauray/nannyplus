import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/views/tab_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/child_list_cubit.dart';
import '../data/model/child.dart';

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
                ? const TextStyle(inherit: true, fontStyle: FontStyle.italic)
                : const TextStyle(inherit: true, fontWeight: FontWeight.bold),
          ),
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                //builder: (context) => ServiceListView(child.id!),
                builder: (context) => TabView(child.id!),
              ),
            );
            context.read<ChildListCubit>().loadChildList();
          },
          subtitle: child.hasAllergies
              ? Text(child.allergies!)
              : Text(context.t("No known allergies")),
          leading: IconButton(
            icon: Icon(
              Icons.phone,
              color: child.hasPhoneNumber ? Colors.green : null,
            ),
            onPressed: () => child.hasPhoneNumber
                ? launch('tel://${child.phoneNumber}')
                : ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.t('No phone number')),
                    ),
                  ),
          ),
          //trailing: PopupMenuButton(
          //  itemBuilder: (context) => [
          //    PopupMenuItem(
          //      value: 'edit',
          //      child: Text(context.t('Edit')),
          //    ),
          //    if (!child.isArchived)
          //      PopupMenuItem(
          //        value: 'archive',
          //        child: Text(context.t('Archive')),
          //      ),
          //    if (child.isArchived)
          //      PopupMenuItem(
          //        value: 'unarchive',
          //        child: Text(context.t('Unarchive')),
          //      ),
          //    const PopupMenuItem(
          //      height: 0,
          //      child: Divider(),
          //    ),
          //    PopupMenuItem(
          //      value: 'invoices',
          //      child: Text(context.t('Invoices')),
          //    ),
          //  ],
          //  onSelected: (value) async {
          //    if (value == 'edit') {
          //      var editedChild = await Navigator.of(context).push<Child>(
          //        MaterialPageRoute(
          //          builder: (context) => ChildForm(
          //            child: child,
          //          ),
          //          fullscreenDialog: true,
          //        ),
          //      );
          //      if (editedChild != null) {
          //        context.read<ChildListCubit>().update(
          //              editedChild.copyWith(
          //                id: _children[index].id,
          //              ),
          //            );
          //      }
          //    } else if (value == 'archive') {
          //      context.read<ChildListCubit>().archive(child);
          //    } else if (value == 'unarchive') {
          //      context.read<ChildListCubit>().unarchive(child);
          //    } else if (value == 'invoices') {
          //      Navigator.of(context).push(
          //        MaterialPageRoute(
          //          builder: (context) => InvoiceListView(child),
          //        ),
          //      );
          //    }
          //  },
          //),
        );
      },
    );
  }
}
