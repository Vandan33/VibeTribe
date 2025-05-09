import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  List<Map<String, dynamic>> _wishlist = [];

  List<Map<String, dynamic>> get wishlist => _wishlist;

  void addToWishlist(Map<String, dynamic> package) {
    if (!_wishlist.any((item) => item['id'] == package['id'])) {
      _wishlist.add(package);
      notifyListeners();
    }
  }

  void removeFromWishlist(String id) {
    _wishlist.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }
}