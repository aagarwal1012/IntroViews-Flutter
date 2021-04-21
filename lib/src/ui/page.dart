import 'package:flutter/material.dart';
import 'package:intro_views_flutter/src/models/page_view_model.dart';

/// This is the class which contains the Page UI.
class Page extends StatelessWidget {
  const Page({
    required this.pageViewModel,
    this.percentVisible = 1.0,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  /// Page details.
  final PageViewModel pageViewModel;

  /// Percent visible of page.
  final double percentVisible;

  /// [MainAxisAlignment].
  final MainAxisAlignment columnMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        pageViewModel.pageBackground,
        Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          color: pageViewModel.pageColor,
          // Opacity is used to create fade in effect
          child: Opacity(
            opacity: percentVisible,
            child: OrientationBuilder(
              builder: (context, orientation) {
                return orientation == Orientation.portrait
                    ? _buildPortraitPage()
                    : __buildLandscapePage();
              },
            ),
          ),
        ),
      ],
    );
  }

  /// When device is Portrait place title, image and body in a [Column].
  Widget _buildPortraitPage() {
    return Column(
      key: const Key('Portrait Page'),
      mainAxisAlignment: columnMainAxisAlignment,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SafeArea(
          child: _TitlePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ),
        Expanded(
          flex: 4,
          child: _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ),
        Flexible(
          flex: 2,
          child: _BodyPageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ),
      ],
    );
  }

  /// If Device is Landscape reorder with row and column.
  Widget __buildLandscapePage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: columnMainAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: SafeArea(
                  child: _TitlePageTransform(
                    percentVisible: percentVisible,
                    pageViewModel: pageViewModel,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: _BodyPageTransform(
                  percentVisible: percentVisible,
                  pageViewModel: pageViewModel,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Body for the Page.
class _BodyPageTransform extends StatelessWidget {
  const _BodyPageTransform({
    Key? key,
    required this.percentVisible,
    required this.pageViewModel,
  }) : super(key: key);

  final double percentVisible;

  final PageViewModel pageViewModel;

  @override
  Widget build(BuildContext context) {
    return Transform(
      // used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 75.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          style: pageViewModel.mergedBodyTextStyle,
          child: pageViewModel.body,
        ),
      ),
    );
  }
}

/// Main Image of the Page.
class _ImagePageTransform extends StatelessWidget {
  const _ImagePageTransform({
    Key? key,
    required this.percentVisible,
    required this.pageViewModel,
  }) : super(key: key);

  final double percentVisible;

  final PageViewModel pageViewModel;

  @override
  Widget build(BuildContext context) {
    return Transform(
      // used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 50.0 * (1 - percentVisible), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 40.0,
        ),
        child: Container(
          child: pageViewModel.mainImage,
        ),
      ),
    );
  }
}

/// Title for the Page.
class _TitlePageTransform extends StatelessWidget {
  const _TitlePageTransform({
    Key? key,
    required this.percentVisible,
    required this.pageViewModel,
  }) : super(key: key);

  final double percentVisible;

  final PageViewModel pageViewModel;

  @override
  Widget build(BuildContext context) {
    return Transform(
      // used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel.mergedTitleTextStyle,
          child: pageViewModel.title,
        ),
      ),
    );
  }
}
