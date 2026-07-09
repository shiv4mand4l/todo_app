import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FlutterInappWebviewScreen extends StatefulWidget {
  const FlutterInappWebviewScreen({super.key});

  @override
  State<FlutterInappWebviewScreen> createState() =>
      _FlutterInappWebviewScreenState();
}

class _FlutterInappWebviewScreenState extends State<FlutterInappWebviewScreen> {
  InAppWebViewController? webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('InAppWebView')),
      body: Column(
        children: [
          // FIX 1: Checks if progress is less than 100% (1.0 fraction)
          if (progress < 1.0)
            LinearProgressIndicator(
              color: Colors.red,
              value: progress,
              backgroundColor: Colors.red.withValues(alpha: 0.2),
            ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri("https://pub.dev/")),
              onProgressChanged: (controller, currentProgress) {
                setState(() {
                  // FIX 2: Divides the new 'currentProgress' variable, not the old state
                  progress = currentProgress / 100;
                });
              },
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onReceivedError: (controller, request, error) {
                // Handle web errors here gracefully
              },
            ),
          ),
        ],
      ),
    );
  }
}
