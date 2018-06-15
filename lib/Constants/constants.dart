import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

/**
 * This package contains all the constants used.
 */

final BUBBLE_WIDTH = 55.0;

final FULL_TARNSITION_PX = 300.0;

final PERCENT_PER_MILLISECOND = 0.00125;

final pages = [
  new PageViewModel(
    color: const Color(0xFF678FB4),
    mainImageAssetPath: '',
    title: 'Hotels',
    body: 'All hotels and hostels are sorted by hospitality rating',
    iconImageAssetPath: '',
    titleTextColor: Colors.white,
    bodyTextColor: Colors.white,
  ),
  new PageViewModel(
    color: const Color(0xFF65B0B4),
    mainImageAssetPath: '',
    title: 'Banks',
    body: 'We carefully verify all banks before adding them into the app',
    iconImageAssetPath: '',
    titleTextColor: Colors.white,
    bodyTextColor: Colors.white,
  ),
  new PageViewModel(
    color: const Color(0xFF9B90BC),
    mainImageAssetPath: '',
    title: 'Store',
    body: 'All local stores are categorized for your convenience',
    iconImageAssetPath: '',
    titleTextColor: Colors.white,
    bodyTextColor: Colors.white,
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

enum TransitionGoal{
  open,
  close,
}