import 'package:paystack_standard/src/model/checkout_response.dart';
import 'package:paystack_standard/src/component/page_router.dart';
import 'package:paystack_standard/src/component/paystack_checkout.dart';
import 'package:flutter/material.dart';

class PaystackStandard {
  final BuildContext context;
  final String checkoutUrl;

  PaystackStandard._internal({required this.context, required this.checkoutUrl});

  factory PaystackStandard({required BuildContext context, required String checkoutUrl}) {
    if (!Uri.parse(checkoutUrl).hasAbsolutePath) {
      throw const FormatException("Invalid checkout URL");
    }
    return PaystackStandard._internal(context: context, checkoutUrl: checkoutUrl);
  }

  Future<CheckoutResponse> checkout() async {
    return await PageRouter.gotoWidget(PaystackCheckout(checkoutUrl: checkoutUrl), context);
  }

  Future<CheckoutResponse?> dialog({
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    RouteSettings? routeSettings,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transitionBuilder,
    Duration? transitionDuration,
  }) {
    return showDialog<CheckoutResponse>(
      context: context,
      barrierDismissible: false,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      builder: (_) => PaystackCheckout(checkoutUrl: checkoutUrl),
    );
  }

  Future<CheckoutResponse?> bottomSheet({
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Color? barrierColor,
    BoxConstraints? constraints,
    bool useSafeArea = false,
  }) {
    return showModalBottomSheet<CheckoutResponse>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      barrierColor: barrierColor,
      constraints: constraints,
      useSafeArea: useSafeArea,
      builder: (_) => PaystackCheckout(checkoutUrl: checkoutUrl),
    );
  }
}
