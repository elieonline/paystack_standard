import 'package:flutter/material.dart';
import 'package:paystack_standard/src/component/paystack_checkout.dart';

import 'model/checkout_response.dart';

class PaystackStandard {
  final BuildContext context;
  final String checkoutUrl;

  const PaystackStandard(this.context, {required this.checkoutUrl});

  Future<CheckoutResponse> checkout({required String checkoutUrl}) async =>
      await Navigator.push(
          context, MaterialPageRoute(
        builder: (context) =>
            PaystackCheckout(
              checkoutUrl: checkoutUrl,
            ),
      ));
