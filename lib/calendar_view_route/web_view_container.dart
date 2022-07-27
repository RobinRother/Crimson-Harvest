import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Displays screen containing the webview.
class WebViewContainer extends StatelessWidget {
  const WebViewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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