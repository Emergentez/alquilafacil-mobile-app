import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NiubizPaymentScreen extends StatelessWidget {
  final String sessionKey;
  final String merchantId;
  final double amount;
  final String purchaseNumber;

  const NiubizPaymentScreen({super.key,
    required this.sessionKey,
    required this.merchantId,
    required this.amount,
    required this.purchaseNumber,
  });

  @override
  Widget build(BuildContext context) {
    final String htmlContent = '''
    <!DOCTYPE html>
    <html>
    <head>
      <link rel="stylesheet" href="https://static-content.vnforapps.com/elements/v1/payform.min.css">
    </head>
    <body>
      <script src="https://static-content.vnforapps.com/elements/v1/payform.min.js"></script>
      <script type="text/javascript">
        var configuration = {
          callbackurl: 'https://mi-backend.com/callback',
          sessionkey: '$sessionKey',
          channel: 'web',
          merchantid: '$merchantId',
          purchasenumber: '$purchaseNumber',
          amount: $amount,
          language: 'es',
          font: 'https://fonts.googleapis.com/css?family=Montserrat:400&display=swap',
        };
        payform.setConfiguration(configuration);
      </script>
    </body>
    </html>
    ''';

    final WebViewController webViewController = WebViewController()
      ..loadHtmlString(htmlContent);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago Niubiz'),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
