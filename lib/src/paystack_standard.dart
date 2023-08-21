import 'package:paystack_standard/src/model/checkout_response.dart';
import 'package:paystack_standard/src/component/page_router.dart';
import 'package:paystack_standard/src/component/paystack_checkout.dart';
import 'package:flutter/material.dart';

class PaystackStandard {
  final BuildContext context;

  PaystackStandard(this.context);

  Future<CheckoutResponse> checkout({required String checkoutUrl}) async {
    bool _isValidUrl = Uri.parse(checkoutUrl).hasAbsolutePath;
    if (!_isValidUrl) throw new FormatException("Invalid checkout Url");

    return await PageRouter.gotoWidget(
        PaystackCheckout(checkoutUrl: checkoutUrl), context);
  }
}
