// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_xuno/screens/emptyScreen.dart';
import 'package:wallet_xuno/screens/recipientScreen.dart';
import 'package:wallet_xuno/screens/tabbed_page.dart';
import 'package:wallet_xuno/screens/wallet_screen.dart';
import 'package:wallet_xuno/screens/wrapper.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

// the one and only GoRouter instance
final goRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    // Stateful nested navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return WrapperWidget(navigationShell: navigationShell);
      },
      branches: [
        // first branch (A)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TabbedScreen(),
              ),
              routes: [
                // child route
                GoRoute(
                  path: 'reciepient',
                  builder: (context, state) => const Recipientscreen(),
                ),
              ],
            ),
          ],
        ),
        // second branch (B)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/account',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Emptyscreen(),
              ),
            ),
          ],
        ),
        // StatefulShellBranch(
        //   navigatorKey: _shellNavigatorBKey,
        //   routes: [
        //     GoRoute(
        //       path: '/recipients',
        //       pageBuilder: (context, state) => const NoTransitionPage(
        //         child: Emptyscreen(), // Updated to match routing
        //       ),
        //     ),
        //   ],
        // ),
      ],
    ),
  ],
);
