import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final TabBar? tabBar;
  const AppView({
    required this.title,
    required this.body,
    this.drawer,
    this.floatingActionButton,
    this.actions,
    this.tabBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              key: const Key('drawer_button'),
            );
          },
        ),
        actions: actions,
        bottom: tabBar,
      ),
      drawer: drawer,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
