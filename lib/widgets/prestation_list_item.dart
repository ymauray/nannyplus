import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/prestation_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';

import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/utils/date_format_extension.dart';
import 'package:nannyplus/views/prestation_form.dart';
import 'package:provider/src/provider.dart';

import 'bold_text.dart';
import 'prestation_list_item_detail.dart';

class PrestationListItem extends StatelessWidget {
  final Prestation prestation;
  final Child child;
  final bool showDivider;

  const PrestationListItem({
    required this.prestation,
    required this.child,
    required this.showDivider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDivider) const Divider(),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: BoldText(prestation.date.formatDate()),
          ),
        Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          //confirmDismiss: _showDismissConfirmationDialog(context),
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Text(
                    context.t('Delete'),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          onDismissed: (direction) {
            //
          },
          child: GestureDetector(
            onTap: () async {
              var prestation = await Navigator.of(context).push(
                MaterialPageRoute<Prestation>(
                  builder: (context) => PrestationForm(
                    prestation: this.prestation,
                  ),
                  fullscreenDialog: true,
                ),
              );
              if (prestation != null) {
                context.read<PrestationListCubit>().create(prestation, child);
              }
            },
            child: PrestationListItemDetail(prestation: prestation),
          ),
        ),
      ],
    );
  }
}
