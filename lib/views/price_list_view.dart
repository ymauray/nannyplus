import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/price_list_cubit.dart';
import 'package:nannyplus/views/app_view.dart';
import 'package:nannyplus/widgets/loading_indicator.dart';
import 'package:nannyplus/widgets/price_list.dart';

class PriceListView extends StatelessWidget {
  const PriceListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PriceListCubit>().getPriceList();

    return AppView(
      title: Text(context.t('Price list')),
      body: BlocConsumer<PriceListCubit, PriceListState>(
        listener: (context, state) {
          if (state is PriceListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PriceListInitial) {
            return const LoadingIndicator();
          } else if (state is PriceListLoaded) {
            return PriceList(state.priceList, state.inUse);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
