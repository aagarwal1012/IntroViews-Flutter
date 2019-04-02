<div align="center"><img src="https://github.com/aagarwal1012/IntroViews-Flutter/blob/master/display/header.png?raw=true"/></div>
<br/>
<div align="center">
	<a href="https://flutter.io">
    <img src="https://img.shields.io/badge/Platform-Flutter-yellow.svg"
      alt="Platform" />
  </a>
  	<a href="https://pub.dartlang.org/packages/intro_views_flutter">
    <img src="https://img.shields.io/pub/v/intro_views_flutter.svg"
      alt="Pub Package" />
  </a>
  	<a href="https://travis-ci.com/aagarwal1012/IntroViews-Flutter">
    <img src="https://travis-ci.com/aagarwal1012/IntroViews-Flutter.svg?branch=master"
      alt="Build Status" />
  </a>
  	<a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-red.svg?style=flat-square"
      alt="License: MIT" />
  </a>
</div><br>

IntroViews is inspired by [Paper Onboarding](https://github.com/Ramotion/paper-onboarding-android) and developed with `love` from scratch. I decided to rewrite almost all the features in order to make it available to the `flutter` developers and extensible as possible.

# Table of contents
  * [Features](#features)
  * [Getting Started](#getting-started)
  * [Usage](#usage)
  * [Documentation](#documentaion)  
  	* [PageViewModel Class](#pageViewModel-class)
  	* [IntroViewFlutter Class](#introViewFlutter-class)
  * [Bugs or Requests](#want-to-contribute-!)
  * [License](#license)

<img src="https://github.com/aagarwal1012/IntroViews-Flutter/blob/master/display/output.gif?raw=true" align = "right" height = "550px">

# Features

- Easy addition of pages.

- Circular page reveal.

- Cool Animations.

- Animation control, if the user stops sliding in the midway.

- Skip button, for skipping the app intro.

- Custom font selection.

- Material Design.

# Getting Started

You should ensure that you add the `intro_views_flutter` as a dependency in your flutter project.

```yaml
dependencies:
  intro_views_flutter: '^2.6.0'
```

You can also reference the git repository directly if you want:

```yaml
dependencies:
  intro_views_flutter:
    git: git://github.com/aagarwal1012/IntroViews-Flutter
```

You should then run `flutter packages get` in your terminal so as to get the package.

# Usage

<img src = "https://github.com/aagarwal1012/IntroViews-Flutter/blob/master/display/page3.png?raw=true" align = "right" height = "450px"/>

- `IntroViewsFlutter` widget require a `list` of `PageViewModel` , and some other parameters. Refer the code below to create a PageViewModel page.

  ```dart
  Final page = new PageViewModel(
      pageColor: const Color(0xFF607D8B),
        iconImageAssetPath: 'assets/taxi-driver.png',
        iconColor: null,
        bubbleBackgroundColor: null,
        body: Text(
          'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
        ),
        title: Text('Cabs'),
        mainImage: Image.asset(
          'assets/taxi.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      );
  ```

- Now refer the code below to get the `IntroViewsFlutter` widget.

  ```dart
  final Widget introViews = new IntroViewsFlutter(
        [page],
        onTapDoneButton: (){
          //Void Callback
        },
        showSkipButton: true,
        pageButtonTextStyles: new TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: "Regular",
          ),
      );
  ```

  For further usage refer the [`example`](https://github.com/aagarwal1012/IntroViews-Flutter/tree/master/example/lib) available.

  For `Landscape` preview click the [link](https://github.com/aagarwal1012/IntroViews-Flutter/blob/master/display/landscape2.png?raw=true).

  **_Note :_** If you added more than four pages in the list then there might be overlapping between `page icons` and `skip button`, so my suggestion is just make the `showSkipButton: false`.

# Documentation

### PageViewModel Class

| Dart attribute        | Datatype       | Description                                                           |                                          Default Value                                          |
| :-------------------- | :------------- | :-------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------: |
| pageColor             | Color          | Set color of the page.                                                |                                              Null                                               |
| mainImage             | Image / Widget | Set the main image of the page.                                       |                                              Null                                               |
| title                 | Text / Widget  | Set the title text of the page.                                       |                                              Null                                               |
| body                  | Text / Widget  | Set the body text of the page.                                        |                                              Null                                               |
| iconImageAssetPath    | String         | Set the icon image asset path that would be displayed in page bubble. |                                              Null                                               |
| iconColor             | Color          | Set the page bubble icon color.                                       |                                              Null                                               |
| bubbleBackgroundColor | Color          | Set the page bubble background color.                                 |                                          Colors.white / Color(0x88FFFFFF)                                           |
| textStyle             | TextStyle      | Set TextStyle for both title and body                                 | title: `color: Colors.white , fontSize: 50.0` <br> body: `color: Colors.white , fontSize: 24.0` |
| bubble                | Widget         | Set a custom widget for the inner bubble                              |                                              null                                               |

### IntroViewFlutter Class

| Dart attribute          | Datatype            | Description                                                                                                       |              Default Value              |
| :---------------------- | :------------------ | :---------------------------------------------------------------------------------------------------------------- | :-------------------------------------: |
| pages                   | List<PageViewModel> | Set the pages of the intro screen.                                                                                |                  Null                   |
| onTapDoneButton         | VoidCallback        | Method executes on tapping done button.                                                                           |                  Null                   |
| onTapBackButton         | VoidCallback        | Method executes on tapping back button.                                                                           |                  Null                   |
| onTapNextButton         | VoidCallback        | Method executes on tapping next button.                                                                           |                  Null                   |
| showSkipButton          | Bool                | Show the skip button at the bottom of page.                                                                       |                  true                   |
| showBackButton          | Bool                | Show the Back button at the bottom of page. Overrides showSkipButton starting from the second page                |                  false                   |
| showNextButton          | Bool                | Show the Next button at the bottom of page. Overrides doneButtonPersist.                                          |                  false                   |
| pageButtonTextSize      | Double              | Set the button text size.                                                                                         |                  18.0                   |
| pageButtonFontFamily    | String              | Set the font of button text.                                                                                      |                 Default                 |
| onTapSkipButton         | VoidCallback        | Method executes on tapping skip button.                                                                           |                  null                   |
| pageButtonTextStyles    | TextStyle           | Configure TextStyle for skip, done buttons, overrides pageButtonFontFamily, pageButtonsColor, pageButtonTextSize. | fontSize: `18.0`, color: `Colors.white` |
| skipText                | Text / Widget       | Override Skip Button Text and styles.                                                                             |              Text('SKIP')               |
| doneText                | Text / Widget       | Override Done Button Text and styles.                                                                             |              Text('DONE')               |
| backText                | Text / Widget       | Override Back Button Text and styles.                                                                             |              Text('BACK')               |
| nextText                | Text / Widget       | Override Next Button Text and styles.                                                                             |              Text('NEXT')               |
| doneButtonPersist       | Bool                | Show done Button throughout pages                                                                                 |                  false                  |
| columnMainAxisAlignment | MainAxisAlignment   | Control [MainAxisAlignment] for column                                                                            |      MainAxisAlignment.spaceAround      |
| fullTransition          | double              | Adjust scroll distance for full transition                                                                        |                  300.0                  |
| background              | Color               | Set the background color to Colors.transparent if you have your own background image below | null |

For help on editing package code, view the [flutter documentation](https://flutter.io/developing-packages/).

# Want to contribute !

This is the well `documented` package. I have documented each and every method that I have used, so have a good read to the code and suggest some changes and new feature to be added in the package. See [Contributing.md](https://github.com/aagarwal1012/IntroViews-Flutter/blob/master/CONTRIBUTING.md).
Feel free to [open an issue](https://github.com/aagarwal1012/IntroViews-Flutter/issues).

# License

**IntroViews-Flutter** is licensed under `MIT license`.
