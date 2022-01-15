library flutter_paxful_pay;

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paxful_pay/screens/payment_screen.dart';

/// FlutterPAXFullPay is a Flutter plugin for PAXFullPay.
class FlutterPAXFulPay {
  static const String _baseUrl = "https://paxful.com/wallet/pay";

  /// Genrate payment URL and open the PAXFullPay payment page.
  /// [context] BuildContext.
  /// [apiKey] Your PAXFul API key.
  /// [merchantId] Your PAXFul merchant ID.
  /// [to] The PAXFullPay wallet address to send the payment to.
  /// [secret] Your PAXFul API secret.
  /// [trackId] Your randomly generated string to track the payment from paxful.
  /// [saveAddress] Save the address to PAXFullPay wallet in case a retry is needed.
  /// [amount] The amount to send in BTC.
  /// [fiatAmount] The amount to send in FIAT currency. Provide this only of
  /// amount is not provided. If you supply this argument, ypou also need to supply
  /// the fiatCurrency argument.
  static void openWebView({
    required BuildContext context,
    required String apiKey,
    required String merchantId,
    required String to,
    required String secret,
    required String trackId,
    bool saveAdress = false,
    double? amount,
    double? fiatAmount,
    String? fiatCurrency,
    String? title,
    @Deprecated("Use appBarBackgroundColor") Color? titleBackgroundColor,
    Color? appBarBackgroundColor,
    Color? appBarTextColor,
    void Function(String)? onPageFinished,
    void Function(int)? onProgress,
    double? appBarElevation,
  }) {
    // Open payment page.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PayemntScreen(
          url: generatePaymentURL(
            apiKey: apiKey,
            merchantId: merchantId,
            to: to,
            secret: secret,
            trackId: trackId,
            saveAddress: saveAdress,
            amount: amount,
            fiatAmount: fiatAmount,
            fiatCurrency: fiatCurrency,
          ),
          title: title,
          appBarBackgroundColor: appBarBackgroundColor ?? titleBackgroundColor,
          onPageFinished: onPageFinished,
          appBarElevation: appBarElevation,
          appBarTextColor: appBarTextColor,
          onProgress: onProgress,
        ),
      ),
    );
  }

  /// Generate Payment URL.
  static String generatePaymentURL({
    required String apiKey,
    required String merchantId,
    required String to,
    required String secret,
    required String trackId,
    bool saveAddress = false,
    double? amount,
    double? fiatAmount,
    String? fiatCurrency,
  }) {
    // Validate
    if (amount == null && (fiatAmount == null || fiatCurrency == null)) {
      throw ArgumentError(
          "Either amount or fiatAmount and fiatCurrency must be provided");
    }

    // Build URL query parameterss
    String params = "apikey=$apiKey";
    params += "&merchant=$merchantId";
    params += "&nonce=" + DateTime.now().millisecondsSinceEpoch.toString();
    params += "&to=$to";
    if (amount != null) {
      params += "&amount=$amount";
    } else {
      params += "&fiat_amount=$fiatAmount";
      params += "&fiat_currency=$fiatCurrency";
    }
    params += "&track_id=$trackId";
    if (saveAddress) params += "&saveaddress=1";

    // Generate api seal according to docs.
    Hmac hmacSha256 = Hmac(sha256, utf8.encode(secret));
    String apiSeal = hmacSha256.convert(utf8.encode(params)).toString();

    // Sign params with api seal.
    params += "&apiseal=$apiSeal";

    return _baseUrl + "?" + params;
  }
}
