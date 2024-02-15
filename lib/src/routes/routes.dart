import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:starter_kit/src/features/main/main_page.dart';
import 'package:starter_kit/src/features/splash/splash_page.dart';

final GoRouter router = GoRouter(
  initialLocation: PathRoutes.root,
  routes: <RouteBase>[
    GoRoute(
      path: PathRoutes.root,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: PathRoutes.main,
          builder: (BuildContext context, GoRouterState state) {
            return MainPage(
              indexPage: int.tryParse(state.uri.queryParameters["page"].toString()),
            );
          },
        ),
      ],
    ),
  ],
);
