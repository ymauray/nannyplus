import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({
    required this.title,
    required this.body,
    this.drawer,
    this.floatingActionButton,
    this.actions,
    this.tabBar,
    Key? key,
  }) : super(key: key);
  final Widget title;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final TabBar? tabBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions,
        bottom: tabBar,
      ),
      drawer: drawer,
      body: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 1.125,
                fontFamily: 'SF Pro Text',
              ),
        ),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
