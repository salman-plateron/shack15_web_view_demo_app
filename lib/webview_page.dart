import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Stateful widget that represents a web view page.
class WebViewPage extends StatefulWidget {
  const WebViewPage({
    super.key,
    required this.authtoken,
    required this.userRefid,
    required this.sessionToken,
    required this.webUrl,
  });

  // Parameters required for web view communication and configuration.
  final String authtoken;
  final String userRefid;
  final String sessionToken;
  final String webUrl;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  final _cookieManager = WebViewCookieManager();

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          widget.webUrl,
        ),
      )
      ..setOnConsoleMessage((message) {
        log('Console Message: ${message.message}');
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  @override
  Future<void> dispose() async {
    _cookieManager.clearCookies();
    _controller.clearCache();
    _controller.clearLocalStorage();
    super.dispose();
  }
}
