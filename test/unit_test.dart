// test/conversion_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('USD to NPR conversion test', () {
    //!setup
    const double usd = 10.0;
    const double rate = 133.64;
    const double expectedNpr = 1336.40;

//!do+expect
    expect(usdToNpr(usd, rate).toStringAsFixed(2),
        expectedNpr.toStringAsFixed(2)); //left actual right what it should be
  });
}

// lib/conversion.dart
double usdToNpr(double usd, double rate) {
  return usd * rate;
}

//test 0, 10, 
//expected 0, 133.64, 1336.40
//rate -10