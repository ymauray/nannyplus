import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../forms/entry_form.dart';
import '../models/entry.dart';
import '../models/folder.dart';
import '../models/rates.dart';
import '../pages/invoices_page.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  context.t("Date"),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  context.t("Duration"),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              const Icon(Icons.wb_sunny_outlined),
              const Icon(Icons.nightlight_round_outlined),
              const Icon(Icons.night_shelter_outlined),
              const SizedBox(
                width: 60,
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}

class EntryRow extends StatelessWidget {
  const EntryRow(this.entry, this.preSchool, {Key? key}) : super(key: key);

  final Entry entry;
  final bool preSchool;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: ListTile(
          visualDensity: VisualDensity.compact,
          dense: true,
          trailing: Text(
            context.t('Delete'),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) async => showDismissDialog(context),
      onDismissed: (direction) {
        context.read<Entries>().deleteEntry(entry);
      },
      key: UniqueKey(),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        dense: true,
        title: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                DateFormat.yMMMd().format(entry.date!),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "${entry.hours!}h${entry.minutes!}${entry.minutes! < 10 ? "0" : ""}",
                textAlign: TextAlign.center,
              ),
            ),
            Icon(entry.lunch! ? Icons.check_box_outlined : Icons.check_box_outline_blank),
            Icon(entry.diner! ? Icons.check_box_outlined : Icons.check_box_outline_blank),
            Icon(entry.night! ? Icons.check_box_outlined : Icons.check_box_outline_blank),
            SizedBox(
              width: 60,
              child: Text(
                entry.total!.toStringAsFixed(2),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        onTap: () async {
          var result = await Navigator.of(context).push<Entry>(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => EntryForm(input: entry),
            ),
          );
          if (result != null) {
            result.id = entry.id;
            result.total = context.read<Rates>().computeTotal(result, preSchool);
            context.read<Entries>().updateEntry(result);
          }
        },
      ),
    );
  }

  Future<bool?> showDismissDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Delete')),
          content: Text(context.t('Are you sure you want to delete this entry ?')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(context.t('Yes')),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'No',
              ),
            ),
          ],
        );
      },
    );
  }
}

class EntriesPage extends StatelessWidget {
  const EntriesPage(this.folder, {Key? key}) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Consumer<Entries>(
      builder: (context, entries, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("${folder.firstName} ${folder.lastName}"),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem<String>(value: "invoices", child: Text(context.t("Invoices"))),
                  const PopupMenuItem(enabled: false, height: 1, child: Divider()),
                  PopupMenuItem<String>(value: "view", child: Text(context.t("View"))),
                  PopupMenuItem<String>(value: "delete", child: Text(context.t("Delete"), style: const TextStyle(color: Colors.red))),
                ],
                onSelected: (value) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => InvoicesPage(folder: folder, entries: entries)));
                },
              ),
            ],
          ),
          body: Column(
            children: [
              ListTile(
                title: Text(
                  "Pending balance : ${entries.total().toStringAsFixed(2)}",
                ),
              ),
              const TableHeader(),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var entry = entries.data[index];
                    return EntryRow(entry, folder.preSchool!);
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  itemCount: entries.data.length,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var returnValue = await Navigator.of(context).push<Entry>(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const EntryForm(),
                ),
              );
              if (returnValue != null) {
                //returnValue.preSchool = returnValue.preSchool ?? folder.preSchool;
                returnValue.total = context.read<Rates>().computeTotal(returnValue, folder.preSchool!);
                entries.createEntry(returnValue);
              }
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
