import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:explore/routing/router_names.dart';
//Screens
import 'package:explore/screens/status_screen.dart';
import 'package:explore/screens/home_page.dart';
import 'package:explore/screens/login_screen.dart';
import 'package:explore/screens/message_screen.dart';
import 'package:explore/screens/notification.dart';
import 'package:explore/screens/profile_screen.dart';
import 'package:explore/screens/register_screen.dart';
import 'package:explore/screens/first_screen.dart';
//Extensions
import 'package:explore/extensions/string_extensions.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;
  switch (routingData.route) {
    case FirstRoute:
      return _getPageRoute(FirstScreenTopBarContents(), settings);
    case HomeRoute:
      return _getPageRoute(HomePage(), settings);
    case MessageRoute:
      return _getPageRoute(MessageScreen(), settings);
    case NotificationRoute:
      return _getPageRoute(notification(), settings);
    case ProfileRoute:
      return _getPageRoute(ProfileScreen(), settings);
    case RegisterRoute:
      return _getPageRoute(RegisterScreen(), settings);
    case StatusRoute:
      return _getPageRoute(StatusScreen(), settings);
    default:
      return _getPageRoute(LoginScreen(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
