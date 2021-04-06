import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Animation_Gesture/animated_page_dragger.dart';
import 'package:intro_views_flutter/Animation_Gesture/page_dragger.dart';
import 'package:intro_views_flutter/Animation_Gesture/page_reveal.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/Models/pager_indicator_view_model.dart';
import 'package:intro_views_flutter/Models/slide_update_model.dart';
import 'package:intro_views_flutter/UI/page.dart' as into_ui_page;
import 'package:intro_views_flutter/UI/page_indicator_buttons.dart';
import 'package:intro_views_flutter/UI/pager_indicator.dart';

/// This is the IntroViewsFlutter widget of app which is a
/// stateful widget as its state is dynamic and updates asynchronously.
class IntroViewsFlutter extends StatefulWidget {
  const IntroViewsFlutter(
    this.pages, {
    Key key,
    this.onTapDoneButton,
    this.showSkipButton = true,
    this.pageButtonTextStyles,
    this.onTapBackButton,
    this.showNextButton = false,
    this.showBackButton = false,
    this.pageButtonTextSize = 18.0,
    this.pageButtonFontFamily,
    this.onTapSkipButton,
    this.onTapNextButton,
    this.pageButtonsColor,
    this.doneText = const Text('DONE'),
    this.nextText = const Text('NEXT'),
    this.skipText = const Text('SKIP'),
    this.backText = const Text('BACK'),
    this.doneButtonPersist = false,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
    this.fullTransition = FULL_TRANSITION_PX,
    this.background,
  }) : super(key: key);

  /// List of [PageViewModel] to display.
  final List<PageViewModel> pages;

  /// Callback on Done button pressed.
  final VoidCallback onTapDoneButton;

  /// Sets the text color for Skip and Done buttons.
  ///
  /// Gets overridden by [pageButtonTextStyles].
  final Color pageButtonsColor;

  /// Whether you want to show the Skip button or not.
  final bool showSkipButton;

  /// Whether you want to show the Next button or not.
  final bool showNextButton;

  /// Whether you want to show the Back button or not.
  final bool showBackButton;

  /// TextStyles for Done and Skip buttons.
  ///
  /// Overrides [pageButtonFontFamily], [pageButtonsColor]
  /// and [pageButtonTextSize].
  final TextStyle pageButtonTextStyles;

  /// Executes when Skip button is pressed.
  final VoidCallback onTapSkipButton;

  /// Executes when Next button is pressed.
  final VoidCallback onTapNextButton;

  /// Executes when Back button is pressed.
  final VoidCallback onTapBackButton;

  /// Sets the text size for Skip and Done buttons.
  ///
  /// Gets overridden by [pageButtonTextStyles].
  final double pageButtonTextSize;

  /// Sets the font family for Skip and Done buttons.
  ///
  /// Gets overridden by [pageButtonTextStyles].
  final String pageButtonFontFamily;

  /// Overrides 'DONE' text with your own text.
  ///
  /// Typically a [Text] widget.
  final Widget doneText;

  /// Overrides 'BACK' text with your own text.
  ///
  /// Typically a [Text] widget.
  final Widget backText;

  /// Overrides 'NEXT' text with your own text.
  ///
  /// Typically a [Text] widget.
  final Widget nextText;

  /// Overrides 'SKIP' text with your own text.
  ///
  /// Typically a [Text] widget.
  final Widget skipText;

  /// Always show `Done` button.
  final bool doneButtonPersist;

  /// [MainAxisAlignment] for [PageViewModel] page column alignment.
  ///
  ///
  /// Defaults to [MainAxisAlignment.spaceAround].
  ///
  /// `Portrait` view wraps around [title], [body] and [mainImage].
  ///
  /// `Landscape` view wraps around [title] and [body].
  final MainAxisAlignment columnMainAxisAlignment;

  /// Adjusts how how much the user must drag for a full page transition.
  ///
  /// Defaults to 300.0.
  final double fullTransition;

  /// Sets the background color to Colors.transparent if you have your own
  /// background image below.
  final Color background;

  @override
  _IntroViewsFlutterState createState() => _IntroViewsFlutterState();
}

/// State of [IntroViewsFlutter] widget.
///
/// It extends the [TickerProviderStateMixin] as it is used for
/// animation control (vsync).
class _IntroViewsFlutterState extends State<IntroViewsFlutter>
    with TickerProviderStateMixin {
  /// Stream controller is used to get all the updates when user
  /// slides across screen.
  StreamController<SlideUpdate> slideUpdateStream;

  /// When user stops dragging then by using this page automatically drags.
  AnimatedPageDragger animatedPageDragger;

  /// Active page index.
  int activePageIndex = 0;

  /// Next page index.
  int nextPageIndex = 0;

  /// Slide direction.
  SlideDirection slideDirection = SlideDirection.none;

  /// Slide percentage (0.0 to 1.0).
  double slidePercent = 0.0;
  StreamSubscription<SlideUpdate> slideUpdateStreamListener;

  @override
  void initState() {
    super.initState();
    // Stream Controller initialization
    slideUpdateStream = StreamController<SlideUpdate>();
    // listening to updates of stream controller
    slideUpdateStreamListener =
        slideUpdateStream.stream.listen((SlideUpdate event) {
      // setState is used to change the values dynamically
      setState(() {
        // if the user is dragging then
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          // conditions on slide direction
          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = max(0, activePageIndex - 1);
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = min(widget.pages.length - 1, activePageIndex + 1);
          } else {
            nextPageIndex = activePageIndex;
          }
        }
        // if the user has done dragging
        else if (event.updateType == UpdateType.doneDragging) {
          // auto completion of event using Animated page dragger
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              // we have to animate the open page reveal
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              // we have to close the page reveal
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            // also next page is active page
            nextPageIndex = activePageIndex;
          }
          // run the animation
          animatedPageDragger.run();
        }
        // when animating
        else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        }
        // done animating
        else if (event.updateType == UpdateType.doneAnimating) {
          activePageIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          //disposing the animation controller
          // animatedPageDragger?.dispose();
        }
      });
    });
  }

  @override
  void dispose() {
    slideUpdateStreamListener?.cancel();
    animatedPageDragger?.dispose();
    slideUpdateStream?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: widget.pageButtonTextSize ?? 18.0,
      color: widget.pageButtonsColor ?? const Color(0x88FFFFFF),
      fontFamily: widget.pageButtonFontFamily,
    ).merge(widget.pageButtonTextStyles);

    final pages = widget.pages;

    return Scaffold(
      // stack is used to place components over one another
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.background,
      body: Stack(
        children: <Widget>[
          into_ui_page.Page(
            pageViewModel: pages[activePageIndex],
            percentVisible: 1.0,
            columnMainAxisAlignment: widget.columnMainAxisAlignment,
          ),
          PageReveal(
            // next page reveal
            revealPercent: slidePercent,
            child: into_ui_page.Page(
                pageViewModel: pages[nextPageIndex],
                percentVisible: slidePercent,
                columnMainAxisAlignment: widget.columnMainAxisAlignment),
          ),
          PagerIndicator(
            // bottom page indicator
            viewModel: PagerIndicatorViewModel(
              pages,
              activePageIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          PageIndicatorButtons(
            // skip and Done buttons
            textStyle: textStyle,
            activePageIndex: activePageIndex,
            totalPages: pages.length,
            onPressedDoneButton: widget.onTapDoneButton,
            // void callback to be executed after pressing done button
            slidePercent: slidePercent,
            slideDirection: slideDirection,
            onPressedSkipButton: () {
              // method executed on pressing skip button
              setState(() {
                activePageIndex = pages.length - 1;
                nextPageIndex = activePageIndex;
                // after skip pressed invoke function
                // this can be used for analytics/page transition
                if (widget.onTapSkipButton != null) {
                  widget.onTapSkipButton();
                }
              });
            },
            showSkipButton: widget.showSkipButton,
            showNextButton: widget.showNextButton,
            showBackButton: widget.showBackButton,
            onPressedNextButton: () {
              // method executed on pressing next button
              setState(() {
                activePageIndex = min(pages.length - 1, activePageIndex + 1);
                nextPageIndex = min(pages.length - 1, nextPageIndex + 1);
                // after next pressed invoke function
                // this can be used for analytics/page transition
                if (widget.onTapNextButton != null) {
                  widget.onTapNextButton();
                }
              });
            },
            onPressedBackButton: () {
              // method executed on pressing back button
              setState(() {
                activePageIndex = max(0, activePageIndex - 1);
                nextPageIndex = max(0, nextPageIndex - 1);
                // after next pressed invoke function
                // this can be used for analytics/page transition
                if (widget.onTapBackButton != null) {
                  widget.onTapBackButton();
                }
              });
            },
            nextText: widget.nextText,
            doneText: widget.doneText,
            backText: widget.backText,
            skipText: widget.skipText,
            doneButtonPersist: widget.doneButtonPersist,
          ),
          PageDragger(
            // used for gesture control
            fullTransitionPX: widget.fullTransition,
            canDragLeftToRight: activePageIndex > 0,
            canDragRightToLeft: activePageIndex < pages.length - 1,
            slideUpdateStream: slideUpdateStream,
          ),
        ],
      ),
    );
  }
}
