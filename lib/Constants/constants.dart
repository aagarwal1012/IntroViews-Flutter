/**
 * This package contains all the constants used.
 */

final BUBBLE_WIDTH = 55.0;

final FULL_TARNSITION_PX = 300.0;

final PERCENT_PER_MILLISECOND = 0.00125;

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

enum UpdateType {
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}

enum TransitionGoal {
  open,
  close,
}
