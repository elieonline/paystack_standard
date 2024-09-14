import 'package:flutter/material.dart';
import 'package:paystack_standard/src/component/xdialog.dart';
import 'package:paystack_standard/src/component/xwarning_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:paystack_standard/src/model/checkout_response.dart';

const paystackColor = Color(0xFF09A5DB);

class PaystackCheckout extends StatefulWidget {
  final String checkoutUrl;
  final Widget Function({required Widget child, VoidCallback? onCanceled})? viewBuilder;

  const PaystackCheckout(
      {super.key, required this.checkoutUrl, this.viewBuilder});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PaystackCheckout> {
  late final WebViewController _controller;
  double _percent = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              if (mounted) {
                setState(() {
                  _percent = (progress / 100);
                });
              }
            },
            onUrlChange: (UrlChange urlChange) {},
            onPageStarted: (String url) {
              if (url.contains("?trxref=")) {
                Uri uri = Uri.parse(url);
                _exit(
                    result: CheckoutResponse(
                        reference: uri.queryParameters['trxref'],
                        success: true));
              }
            },
            onPageFinished: (String url) {
              _percent = 1;
              _hideCancelButton();
            }),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  _hideCancelButton() async {
    const hideButtonScript = '''
      const waitForVisibleButtonMobile = async () => {
        while (true) {
          const cancelButton = Array.from(document.querySelectorAll('button span.text')).find(span => span.textContent === 'Cancel Payment');
          if (cancelButton) {
            return true;
          }
          await new Promise(resolve => requestAnimationFrame(resolve));
        }
      };
      
      const waitForVisibleButtonWeb = async () => {
        while (true) {
          const closeButton = document.querySelectorAll('button[aria-label="Close"]')[0];
          if (closeButton) {
            return true;
          }
          await new Promise(resolve => requestAnimationFrame(resolve));
        }
      };

   waitForVisibleButtonWeb().then(() => {
        const closeButton = document.querySelectorAll('button[aria-label="Close"]')[0];
        if (closeButton) {
          closeButton.style.display = 'none';
        }
      });
      
      waitForVisibleButtonMobile().then(() => {
          const cancelButton = Array.from(document.querySelectorAll('button span.text')).find(span => span.textContent === 'Cancel Payment');
          if (cancelButton) {
            cancelButton.parentElement.style.display = 'none';
          }
      });
    ''';

    await _controller.runJavaScript(hideButtonScript);
  }

  void _exit({required CheckoutResponse result}) =>
      Navigator.of(context).pop(result);

  _showCancelWarning() => XDialog(context,
          child: XWarningDialog(
              onNegative: () {},
              onPositive: () => _exit(result: CheckoutResponse(reference: "")),
              description:
                  "Are you sure? You are about to cancel the transaction",
              positive: "Yes",
              title: "Cancel Transaction?"))
      .show();

  @override
  Widget build(BuildContext context) {
    final body = WillPopScope(
      onWillPop: () async {
        _showCancelWarning();
        return false;
      },
      child: SafeArea(
        child: Column(
          children: [
            if (_percent < 1)
              LinearPercentIndicator(
                  percent: _percent,
                  lineHeight: 2,
                  progressColor: paystackColor),
            Expanded(child: WebViewWidget(controller: _controller))
          ],
        ),
      ),
    );

    if (widget.viewBuilder != null) {
      return widget.viewBuilder!(child: body, onCanceled: _showCancelWarning());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Paystack Checkout",
              style: TextStyle(color: Colors.black),
            ),
            GestureDetector(
              onTap: () => _showCancelWarning(),
              child: const Icon(Icons.close),
            )
          ],
        ),
      ),
      body: body,
    );
  }
}
