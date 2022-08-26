import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/cubit/yearly_statements_cubit.dart';
import 'package:nannyplus/data/model/yearly_statement.dart';

import '../../data/model/monthly_statement.dart';
import '../constants.dart';
import '../ui/list_view.dart';
import '../ui/sliver_curved_persistent_header.dart';
import '../ui/ui_card.dart';
import '../ui/view.dart';

class StatementsView extends StatelessWidget {
  const StatementsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<YearlyStatementsCubit>().loadStatements();

    return BlocBuilder<YearlyStatementsCubit, YearlyStatementsState>(
      builder: (context, state) {
        return UIView(
          title: Text(
            context.t('Statements'),
          ),
          persistentHeader:
              const UISliverCurvedPersistenHeader(child: Text('')),
          body: UIListView.fromChildren(
            horizontalPadding: kdDefaultPadding,
            children: [
              if (state is YearlyStatementsLoaded)
                ...(() sync* {
                  for (final statement in state.statements) {
                    yield _YearlyStatementCard(statement: statement);
                  }
                })(),
            ],
          ),
        );
      },
    );
  }
}

class _YearlyStatementCard extends StatelessWidget {
  const _YearlyStatementCard({
    Key? key,
    required this.statement,
  }) : super(key: key);

  final YearlyStatement statement;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${statement.year}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    statement.amount.toStringAsFixed(2),
                  ),
                ),
                onTap: () => openPDF(context),
              ),
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const Divider(
          height: 2,
        ),
        ...statement.monthlyStatements.map(
          (statement) => _MonthlyStatementCard(
            statement: statement,
          ),
        ),
      ],
    );
  }

  void openPDF(BuildContext context) {
    //Navigator.of(context).push(
    //  MaterialPageRoute(
    //    builder: (context) => InvoiceView(
    //      invoice,
    //      GettextLocalizations.of(context),
    //    ),
    //  ),
    //);
  }
}

class _MonthlyStatementCard extends StatelessWidget {
  const _MonthlyStatementCard({
    Key? key,
    required this.statement,
  }) : super(key: key);

  final MonthlyStatement statement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Text(
                DateFormat('MMMM').format(statement.date),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () => openPDF(context),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                statement.amount.toStringAsFixed(2),
              ),
            ),
            onTap: () => openPDF(context),
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void openPDF(BuildContext context) {
    //Navigator.of(context).push(
    //  MaterialPageRoute(
    //    builder: (context) => InvoiceView(
    //      invoice,
    //      GettextLocalizations.of(context),
    //    ),
    //  ),
    //);
  }
}
