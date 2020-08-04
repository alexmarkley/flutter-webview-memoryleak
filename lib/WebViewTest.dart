import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key key}) : super(key: key);

  @override
  createState() => WebViewTestState();
}

class WebViewTestState extends State<WebViewTest> {
  JavascriptChannel channelObserve;

  @override
  void initState() {
    super.initState();
    print("WIDGET INITSTATE WebViewTest");
    channelObserve = JavascriptChannel(
      name: 'Observe',
      onMessageReceived: (JavascriptMessage message) {
        print("Got a message from inside the WebView: ${message.message}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILD WebViewTest");
    String contentBase64 = base64Encode(
        const Utf8Encoder().convert('<html><body>Hello World</body></html>'));
    return Scaffold(
      appBar: AppBar(
        title: Text('A WebView'),
      ),
      body: WebView(
        initialUrl: 'data:text/html;base64,$contentBase64',
        javascriptChannels: {channelObserve},
      ),
    );
  }

  @override
  void dispose() {
    print("WIDGET DISPOSE WebViewTest");
    super.dispose();
  }
}
