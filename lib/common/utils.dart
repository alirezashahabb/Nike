import 'package:flutter/material.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

/// for priceLabel
extension PriceLabel on int {
  String get withPriceLabe => '$this تومان';
}
