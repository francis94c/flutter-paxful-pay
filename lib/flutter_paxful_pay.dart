library flutter_paxful_pay;

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paxful_pay/screens/payment_screen.dart';

/// FlutterPAXFullPay is a Flutter plugin for PAXFullPay.
class FlutterPAXFulPay {
  static const String _baseUrl = "https://paxful.com/wallet/pay";

  /// Open the PAXFullPay payment page.
  void openWebView(
      {required BuildContext context,
      required String apiKey,
      required String merchantId,
      required String to,
      required double amount,
      required String secret,
      bool saveAdress = true,
      String? trackId}) {
    // Build URL query parameterss
    String params = "apikey=$apiKey";
    params += "&merchant=$merchantId";
    params += "&nonce=" + DateTime.now().millisecondsSinceEpoch.toString();
    params += "&to=$to";
    params += "&amount=$amount";
    if (trackId != null) params += "&track_id=$trackId";

    // Generate api seal according to docs.
    Hmac hmacSha256 = Hmac(sha256, utf8.encode(secret));
    String apiSeal = hmacSha256.convert(utf8.encode(params)).toString();

    // Sign params with api seal.
    params += "&api_seal=$apiSeal";

    // Open payment page.
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            PayemntScreen(url: _baseUrl + "?" + params)));
  }
}
