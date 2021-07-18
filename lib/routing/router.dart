import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/screens/jobs_share_screen.dart';
import 'package:logafic/screens/showUserInformationScreen.dart';
import 'package:logafic/screens/show_my_jobs_posts.dart';
//Screens
import 'package:logafic/screens/status_screen.dart';
import 'package:logafic/screens/home_page.dart';
import 'package:logafic/screens/login_screen.dart';
import 'package:logafic/screens/message_screen.dart';
import 'package:logafic/screens/notification_screen.dart';
import 'package:logafic/screens/profile_screen.dart';
import 'package:logafic/screens/register_screen.dart';
import 'package:logafic/screens/first_screen.dart';
import 'package:logafic/screens/reset_password_screen.dart';
//Extensions
import 'package:logafic/extensions/string_extensions.dart';
import 'package:logafic/screens/update_user_information.dart';
import 'package:logafic/screens/user_information_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  AuthController authController = AuthController.to;

  var routingData = settings.name?.getRoutingData;
  switch (routingData?.route) {
    case FirstRoute:
      return _getPageRoute(FirstScreenTopBarContents(), settings);
    case HomeRoute:
      return _getPageRoute(HomePage(), settings);
    case MessageRoute:
      return authController.firebaseUser.value!.uid == ''
          ? _getPageRoute(FirstScreenTopBarContents(), settings)
          : _getPageRoute(MyHomePage(), settings);
    case NotificationRoute:
      return authController.firebaseUser.value!.uid == ''
          ? _getPageRoute(FirstScreenTopBarContents(), settings)
          : _getPageRoute(NotificationScreen(), settings);
    case JobsScreenRoute:
      return _getPageRoute(JobsShareScreen(), settings);
    case FullProfileRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      return _getPageRoute(
          ShowFullUserInformationScreen(
            userId: arguments['userId'],
          ),
          settings);
    case ProfileRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      return authController.firebaseUser.value!.uid == ''
          ? _getPageRoute(FirstScreenTopBarContents(), settings)
          : _getPageRoute(
              ProfileScreen(
                userId: arguments['userId'],
              ),
              settings);
    case UpdateUserInformationRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      return authController.firebaseUser.value!.uid == ''
          ? _getPageRoute(FirstScreenTopBarContents(), settings)
          : _getPageRoute(
              UpdateUserInformation(userId: arguments['userId']), settings);
    case RegisterRoute:
      return _getPageRoute(RegisterScreen(), settings);
    case MyJobsRoute:
      return _getPageRoute(ShowMyJobsPostScreen(), settings);
    case ResetRoute:
      return _getPageRoute(ResetPasswordUI(), settings);
    case StatusRoute:
      final arguments = settings.arguments as Map<String, dynamic>;
      return _getPageRoute(
          StatusScreen(
            id: arguments['id'],
          ),
          settings);
    case UserInformationRoute:
      return authController.firebaseUser.value!.uid == ''
          ? _getPageRoute(FirstScreenTopBarContents(), settings)
          : _getPageRoute(UserInformation(), settings);
    default:
      return _getPageRoute(LoginScreen(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String? routeName;
  _FadeRoute({required this.child, required this.routeName})
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
