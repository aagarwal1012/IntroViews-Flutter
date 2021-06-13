import 'package:flutter/cupertino.dart';

extension BuildContextExt on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
}
