import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_paxful_pay/flutter_paxful_pay.dart';

void main() {
  test('URL generation conforms to standards', () {
    // BTC
    String url = FlutterPAXFulPay.generatePaymentURL(
        apiKey: "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        merchantId: "ABC",
        to: "btc_address",
        secret: 'secret',
        trackId: 'uuid',
        amount: 0.55,
        saveAddress: false);

    expect(url.contains("https://paxful.com/wallet/pay?"), true);
    expect(url.contains("apikey=ABCDEFGHIJKLMNOPQRSTUVWXYZ"), true);
    expect(url.contains("merchant=ABC"), true);
    expect(url.contains("to=btc_address"), true);
    expect(url.contains("track_id=uuid"), true);
    expect(url.contains("amount=0.55"), true);

    expect(url.contains("nonce"), true);
    expect(url.contains("apiseal"), true);

    expect(url.contains("fiat_amount"), false);
    expect(url.contains("fiat_currency"), false);
    expect(url.contains("saveaddress"), false);

    // FIAT
    url = FlutterPAXFulPay.generatePaymentURL(
      apiKey: "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      merchantId: "ABC",
      to: "btc_address",
      secret: 'secret',
      trackId: 'uuid',
      fiatAmount: 50,
      fiatCurrency: "USD",
    );

    expect(url.contains("https://paxful.com/wallet/pay?"), true);
    expect(url.contains("apikey=ABCDEFGHIJKLMNOPQRSTUVWXYZ"), true);
    expect(url.contains("merchant=ABC"), true);
    expect(url.contains("to=btc_address"), true);
    expect(url.contains("track_id=uuid"), true);
    expect(url.contains("fiat_amount=50"), true);
    expect(url.contains("fiat_currency=USD"), true);
    expect(url.contains("saveaddress"), true);

    expect(url.contains("apiseal"), true);
    expect(url.contains("nonce"), true);
  });

  test('Validation', () {
    expect(
        () => FlutterPAXFulPay.generatePaymentURL(
              apiKey: "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
              merchantId: "ABC",
              to: "btc_address",
              secret: 'secret',
              trackId: 'uuid',
            ),
        throwsA(predicate((e) =>
            e is ArgumentError &&
            e.message ==
                "Either amount or fiatAmount and fiatCurrency must be provided")));

    expect(
      () => FlutterPAXFulPay.generatePaymentURL(
          apiKey: "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
          merchantId: "ABC",
          to: "btc_address",
          secret: 'secret',
          trackId: 'uuid',
          fiatAmount: 500),
      throwsA(
        predicate((e) =>
            e is ArgumentError &&
            e.message ==
                "Either amount or fiatAmount and fiatCurrency must be provided"),
      ),
    );
  });
}
