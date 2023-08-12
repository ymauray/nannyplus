import 'package:flutter/material.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/sliver_tab_bar_peristant_header.dart';

class UIView extends StatelessWidget {
  const UIView({
    required this.body,
    this.drawer,
    this.title,
    this.persistentHeader,
    this.persistentTabBar,
    this.onFloatingActionPressed,
    this.actions,
    this.bottomNavigationBar,
    super.key,
  });

  final Widget? drawer;
  final Widget? title;
  final UISliverCurvedPersistenHeader? persistentHeader;
  final UISliverTabBarPeristantHeader? persistentTabBar;
  final VoidCallback? onFloatingActionPressed;
  final List<Widget>? actions;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      drawer: drawer,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              title: title,
              centerTitle: true,
              actions: actions,
            ),
            if (persistentHeader != null)
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: persistentHeader,
              ),
            if (persistentTabBar != null) persistentTabBar!,
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverFillRemaining(child: body),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );

    return onFloatingActionPressed == null
        ? scaffold
        : Stack(
            children: [
              scaffold,
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FloatingActionButton(
                    onPressed: onFloatingActionPressed,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          );
  }
}
