import 'package:flutter/material.dart';

class PageRouter {
  static Future gotoWidget(Widget screen, BuildContext context,
      {bool clearStack = false, bool fullScreenDialog = false}) {
    return !clearStack
        ? Navigator.of(context).push(RouteTransition(
        builder: (context) => screen, fullscreenDialog: fullScreenDialog))
        : Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => screen,
            fullscreenDialog: fullScreenDialog),
            (_) => false);
  }

  static void goBack(BuildContext context,
      {bool rootNavigator = false, result}) {
    Navigator.of(context, rootNavigator: rootNavigator).pop(result);
  }
}

/// The main class that defines a custom Route transition / animation
/// [WidgetBuilder builder] is required
/// [Curves curves] is optional , by default it is set to [Curves.easeInOut]
class RouteTransition extends MaterialPageRoute {
  Cubic curves;

  RouteTransition(
      {required WidgetBuilder builder,
        RouteSettings? settings,
        this.curves = Curves.easeInOut,
        bool maintainState = true,
        bool fullscreenDialog = false})
      : super(
      builder: builder,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    Animation customAnimation;
    customAnimation =
        Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
            .animate(CurvedAnimation(
          parent: animation,
          curve: curves,
        ));
    return SlideTransition(
      position: customAnimation as Animation<Offset>,
      child: child,
    );
  }
}
