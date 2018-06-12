import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

final pages = [
  new PageViewModel(
      const Color(0xFF678FB4),
      'assets/hotels.png',
      'Hotels',
      'All hotels and hostels are sorted by hospitality rating',
      'assets/key.png'
  ),
  new PageViewModel(
      const Color(0xFF65B0B4),
      'assets/banks.png',
      'Banks',
      'We carefully verify all banks before adding them into the app',
      'assets/wallet.png'
  ),
  new PageViewModel(
    const Color(0xFF9B90BC),
    'assets/stores.png',
    'Store',
    'All local stores are categorized for your convenience',
    'assets/shopping_cart.png',
  ),
];


enum SlideDirection{
  leftToRight,
  rightToLeft,
  none,
}

enum UpdateType{
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}