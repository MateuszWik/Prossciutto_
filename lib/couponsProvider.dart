import 'package:flutter/material.dart';
import 'cart.dart';
import 'coupons.dart';


class CouponProvider extends ChangeNotifier {
  Coupon? _appliedCoupon;

  Coupon? get appliedCoupon => _appliedCoupon;

  void applyCoupon(Coupon coupon) {
    _appliedCoupon = coupon;
    notifyListeners();
  }
}
