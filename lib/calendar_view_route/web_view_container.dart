import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WebViewController _controller;
    return WebView(
      initialUrl: 'https://github.com/AlexandraSchmalz/Crimson-Harvest',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
      },
    );
  }
}