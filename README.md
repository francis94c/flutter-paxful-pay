# flutter_paxful_pay

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This package helps you generate PaxFul Pay URLs with parameters, and additionally opens a WebView to the generated URL for payment..

## Features

- Generate PAxFul Pay URLs with parameters, See [PaxFulPay Documentation](https://developers.paxful.com/documentation/paxful-pay)
- Opens a WebView to the generated URL for payment

## Getting started

Add the below to your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_paxful_pay: ^0.0.1
```

and import with

```dart
import 'package:flutter_paxful_pay/flutter_paxful_pay.dart';
```

## Usage

To open the payment web view directly with parameters, use the following:

```dart
import 'package:flutter_paxful_pay/flutter_paxful_pay.dart';

String paymentURL = FlutterPAXFulPay.openWebView(
    apiKey: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", // Change.
    merchantId: "abc", // Change.
    to: "BTC_ADDRESS", // Change.
    secret: "secret", // Change.
    trackId: "uuid", // Unique ID for all transactions... Used for tracking on your backend...
    saveAddress = true,
    amount: 0.005, // BTC amount.
);
```

**NB:** You can prompt to pay BTC or FIAT. For BTC, the example above will suffice. For FIAT, you will need to omit the `amount` argument and provide the `fiatAmount` and `fiatCurrency` arguments instead. If you provided `amount`, `fiatAmount`, and `fiatCurrency` all together, `amount` will be ignored.

To generate **BTC** payment URLs, use the following:

```dart
import 'package:flutter_paxful_pay/flutter_paxful_pay.dart';

String paymentURL = FlutterPAXFulPay.generatePaymentURL(
    apiKey: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", // Change.
    merchantId: "abc", // Change.
    to: "BTC_ADDRESS", // Change.
    secret: "secret", // Change.
    trackId: "uuid", // Unique ID for all transactions... Used for tracking on your backend...
    saveAddress = true,
    amount: 0.005, // BTC amount. Min is 0.0004 from PaxFul.
);
```

To Generate **FIAT** payment URLs, use the following:

```dart
import 'package:flutter_paxful_pay/flutter_paxful_pay.dart';

String paymentURL = FlutterPAXFulPay.generatePaymentURL(
    apiKey: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", // Change.
    merchantId: "abc", // Change.
    to: "BTC_ADDRESS", // Change.
    secret: "secret", // Change.
    trackId: "uuid", // Unique ID for all transactions... Used for tracking on your backend...
    saveAddress = true,
    fiatAmount: 70, // FIAT amount.
    fiatCurrency: "USD", // FIAT currency.
);
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
