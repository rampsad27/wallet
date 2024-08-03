import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_xuno/screens/hoem.dart';
import 'package:wallet_xuno/screens/new.dart';
import 'package:wallet_xuno/screens/wallet_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: "/",
    navigatorKey: navigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return Scaffold(
            body: Row(
              children: [
                const NavigationRailWidget(),
                Expanded(child: child),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const WalletScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      ),
    ],
  );
}
