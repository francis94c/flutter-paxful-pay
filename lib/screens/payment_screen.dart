import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PayemntScreen extends StatelessWidget {
  final String? title;
  final String url;

  const PayemntScreen({Key? key, this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title == null ? "PAXFul Pay" : "$title - PAXFul Pay"),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
