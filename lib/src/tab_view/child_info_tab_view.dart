import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/widgets/loading_indicator.dart';

import '../../cubit/child_info_cubit.dart';
import '../../data/model/child.dart';
import '../../utils/date_format_extension.dart';

class NewChildInfoTabView extends StatelessWidget {
  const NewChildInfoTabView({
    Key? key,
    required this.childId,
  }) : super(key: key);

  final int childId;

  @override
  Widget build(BuildContext context) {
    context.read<ChildInfoCubit>().read(childId);

    return BlocConsumer<ChildInfoCubit, ChildInfoState>(
      listener: (context, state) {
        if (state is ChildInfoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t('Error loading invoices')),
            ),
          );
        }
      },
      builder: (context, state) {
        return state is ChildInfoLoaded
            ? _ChildInfo(child: state.child)
            : const LoadingIndicator();
      },
    );
  }
}

class _ChildInfo extends StatelessWidget {
  const _ChildInfo({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Child child;

  @override
  Widget build(BuildContext context) {
    return UIListView.fromChildren(
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
      ],
    );
  }
}
