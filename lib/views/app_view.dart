import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  const AppView({
    required this.title,
    required this.body,
    this.drawer,
    this.floatingActionButton,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions,
      ),
      drawer: drawer,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
