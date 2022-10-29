import 'package:flutter/material.dart';
import 'package:nannyplus/src/common/loading_indicator.dart';

class LoadingIndicatorListView extends StatelessWidget {
  const LoadingIndicatorListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewLoadingIndicator(),
      ],
    );
  }
}
