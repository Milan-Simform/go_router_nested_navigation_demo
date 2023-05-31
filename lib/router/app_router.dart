import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_nested_navigation_2_0/modules/scaffold_with_nav_bar.dart';

class AppRouter {
  AppRouter._internal();
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  final router = GoRouter(
    initialLocation: '/a',
    // navigatorKey: navigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/a',
                builder: (context, state) {
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('A'),
                          ElevatedButton(
                            onPressed: () {
                              context.goNamed('b');
                            },
                            child: const Text('Go to B'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'b',
                    name: 'b',
                    builder: (context, state) {
                      return Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('B'),
                              ElevatedButton(
                                onPressed: () {
                                  context.goNamed('c');
                                },
                                child: const Text('Go to C'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'c',
                        name: 'c',
                        builder: (context, state) {
                          return const Scaffold(
                            body: Center(
                              child: Text('C'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/x',
                builder: (context, state) {
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('X'),
                          ElevatedButton(
                            onPressed: () {
                              // context.pushNamed('outer-b');
                              navigatorKey.currentState!.pushNamed('/boom');
                            },
                            child: const Text('Go to Y'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'y',
                    name: 'y',
                    builder: (context, state) {
                      return const Scaffold(
                        body: Center(
                          child: Text('Y'),
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'z',
                        builder: (context, state) {
                          return const Scaffold(
                            body: Center(
                              child: Text('Z'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/outer-b',
        name: 'outer-b',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Smiling B'),
          ),
        ),
      ),
    ],
  );
}
