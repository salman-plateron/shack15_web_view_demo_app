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
  // Controller for interacting with the WebView.
  late final WebViewController _controller;
  // Manager for handling cookies.
  final _cookieManager = WebViewCookieManager();

  @override
  void initState() {
    super.initState();
    // Initialize the WebView controller.
    _controller = WebViewController()
      // Allow JavaScript execution in the WebView.
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // Define navigation delegate callbacks.
      ..setNavigationDelegate(
        NavigationDelegate(
          // Called when a page starts loading.
          onPageStarted: (url) async {
            await _sendMessageToWebView();
          },
          // Called when a page finishes loading.
          onPageFinished: (url) async {
            await _sendMessageToWebView();
          },
        ),
      )
      // Load the initial URL passed via widget.
      ..loadRequest(
        Uri.parse(
          widget.webUrl,
        ),
      )
      // Log JavaScript console messages for debugging.
      ..setOnConsoleMessage((message) {
        log('Console Message: ${message.message}');
      });
  }

  // Helper method to send custom messages to the WebView.
  Future<void> _sendMessageToWebView() async {
    // Sending a JSON formatted message with authentication details.
    await _controller.runJavaScript("""
    window.postMessage(JSON.stringify({
      channelName: 'Nova.com',
      authToken: '${widget.authtoken}',
      userRefId: '${widget.userRefid}',
      sessionToken: '${widget.sessionToken}',
    }), "*");
  """);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Prevent the widget from resizing when the on-screen keyboard appears.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('WebView')),
      // Display the WebView widget using the controller.
      body: WebViewWidget(controller: _controller),
    );
  }

  @override
  Future<void> dispose() async {
    // Clear all cookies when disposing of the web view.
    _cookieManager.clearCookies();
    // Clean up web view caches and local storage for security.
    _controller.clearCache();
    _controller.clearLocalStorage();
    // Call the super class dispose method.
    super.dispose();
  }
}
