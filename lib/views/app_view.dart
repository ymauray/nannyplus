import 'package:flutter/material.dart';
import 'package:nannyplus/widgets/main_drawer.dart';

class AppView extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget? floatingActionButton;

  const AppView({
    required this.title,
    required this.body,
    this.floatingActionButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      drawer: (ModalRoute.of(context) as PageRoute).fullscreenDialog
          ? null
          : const MainDrawer(),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
