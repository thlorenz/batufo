import 'package:batufo/universe.dart';
import 'package:batufo/widgets/screens/home_widget.dart';
import 'package:batufo/widgets/screens/instructions_widget.dart';
import 'package:batufo/widgets/screens/universe_widget.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String HOME = '/';
  static const String UNIVERSE = '/universe';
  static const String INSTRUCTIONS = '/instructions';
}

class Router {
  final Universe universe;

  Router({@required this.universe});

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME:
        return MaterialPageRoute<void>(
          builder: (_) => SafeArea(
            child: HomeWidget(),
          ),
          settings: settings,
        );
      case Routes.UNIVERSE:
        return MaterialPageRoute<void>(
          builder: (_) => SafeArea(
            child: UniverseWidget(
              universe: universe,
            ),
          ),
        );
      case Routes.INSTRUCTIONS:
        return MaterialPageRoute<void>(
          builder: (_) => SafeArea(
            child: InstructionsWidget(
              platform: universe.platform,
            ),
          ),
        );
      default:
        return MaterialPageRoute<Scaffold>(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
