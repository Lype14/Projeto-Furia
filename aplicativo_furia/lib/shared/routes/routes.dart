import 'package:aplicativo_furia/app/views/home_page.dart';
import 'package:aplicativo_furia/app/views/live_page.dart';
import 'package:aplicativo_furia/app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'livePage',
            builder: (BuildContext context, GoRouterState state) {
              return const LivePage();
            },
          ),
          GoRoute(path: 'HomePage', builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          }),
        ],
      ),
    ],
  );
}
