import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:rps_game/entry_page.dart';
import 'package:wallet_xuno/screens/entry_page.dart';

class WrapperWidget extends StatelessWidget {
  const WrapperWidget({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScaffoldWithNavigationRail(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      );
    });
  }
}
