import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_paxful_pay/flutter_paxful_pay.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> _secrets = {};
  late final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/json/secrets.json').then((string) {
      _secrets = json.decode(string);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: const Text('Pay'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () => FlutterPAXFulPay.openWebView(
                  context: context,
                  apiKey: _secrets['api_key'],
                  merchantId: _secrets['merchant_id'],
                  to: 'bc1q83uzyzvt256k670uazjse9f0877vpze053m90v',
                  fiatAmount: 50,
                  fiatCurrency: 'USD',
                  trackId: _uuid.v4(),
                  secret: _secrets['secret'],
                  appBarBackgroundColor: Colors.white,
                  appBarTextColor: Colors.purple,
                  appBarElevation: 0),
            ),
          ],
        ),
      ),
    );
  }
}
