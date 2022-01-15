import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PayemntScreen extends StatelessWidget {
  final String? title;
  final String url;
  final Color? titleBackgroundColor;
  final Color? appBarBackgroundColor;
  final Color? appBarTextColor;
  final void Function(String)? onPageFinished;
  final void Function(int)? onProgress;
  final double? appBarElevation;

  const PayemntScreen({
    Key? key,
    this.title,
    required this.url,
    @Deprecated("Use appBarBackgroundColor") this.titleBackgroundColor,
    this.appBarBackgroundColor,
    this.appBarTextColor,
    this.appBarElevation,
    this.onProgress,
    this.onPageFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(title == null ? "PAXFul Pay" : "$title - PAXFul Pay"),
          backgroundColor: appBarBackgroundColor ?? titleBackgroundColor,
          elevation: appBarElevation,
          foregroundColor: appBarTextColor,
        ),
        Expanded(
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: onPageFinished,
            onProgress: (int progress) => onProgress?.call(progress),
          ),
        ),
      ],
    );
  }
}
