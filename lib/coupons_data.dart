class Coupon {
  final String title;
  final String description;
  Coupon({required this.title, required this.description});
}
class CouponData {
  static final List<Coupon> _appliedCoupons = [];

  static void applyCoupon(Coupon coupon) {
    if (!_appliedCoupons.any((c) => c.title == coupon.title)) {
      _appliedCoupons.add(coupon);
    }
  }

  static void removeCoupon(Coupon coupon) {
    _appliedCoupons.removeWhere((c) => c.title == coupon.title);
  }

  static List<Coupon> get appliedCoupons => List.unmodifiable(_appliedCoupons);

  static void clearCoupons() {
    _appliedCoupons.clear();
  }
}