import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/favorite/favourite_page.dart';
import '../pages/home/home_page.dart';
import 'navigate_bottom_bar.dart';

export '../router/router_extensions.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root_page');
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorFavouritesKey = GlobalKey<NavigatorState>(debugLabel: 'favourites');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: HomePage.routeName,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        //
        // HomePage
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          initialLocation: HomePage.routeName,
          routes: [
            GoRoute(
              name: '$HomePage',
              path: HomePage.routeName,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),

        //
        // FavouritePage
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavouritesKey,
          initialLocation: FavouritePage.routeName,
          routes: [
            GoRoute(
              name: '$FavouritePage',
              path: FavouritePage.routeName,
              builder: (context, state) => const FavouritePage(),
            ),
          ],
        ),
      ],
    ),
  ],
  // errorBuilder: (context, state) {},
  redirect: (context, state) {
    return null;
  },
);
