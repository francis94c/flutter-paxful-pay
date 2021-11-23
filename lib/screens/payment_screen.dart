import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PayemntScreen extends StatelessWidget {
  final String? title;
  final String url;
  final Color? titleBackgroundColor;

  const PayemntScreen(
      {Key? key, this.title, required this.url, this.titleBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title == null ? "PAXFul Pay" : "$title - PAXFul Pay"),
        backgroundColor: titleBackgroundColor,
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
