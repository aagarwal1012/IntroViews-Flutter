<div align="center"><img src="https://github.com/aagarwal1012/IntroViews-Flutter/blob/master/display/header.png?raw=true"/></div>
<br/>

IntroViews is inspired by [Paper Onboarding](https://github.com/Ramotion/paper-onboarding-android) and developed with `love` from scratch. I decided to rewrite almost all the features in order to make it available to the `flutter` developers and extensible as possible.


<img src="https://github.com/aagarwal1012/IntroViews-Flutter/blob/master/display/output.gif?raw=true" align = "right" height = "550px">

#  Features

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
 intro_views_flutter: "^1.0.2"
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
      title: Text('Cabs'),
      mainImage: Image.asset('assets/taxi.png'),
      body: Text(
        'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
      ),
      textStyle: TextStyle(fontFamily: 'MyFont'),
      iconImageAssetPath: 'assets/taxi-driver.png',
      bubbleBackgroundColor: Colors.white,
      iconColor: null,
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
        pageButtonFontFamily: "Regular",
        pageButtonsColor: Colors.white,
        pageButtonTextSize: 18.0,
      );
  ```
  For further usage refer the [`example`](https://github.com/aagarwal1012/IntroViews-Flutter/tree/master/example/lib) available.

  For `Landscape` preview click the [link](https://github.com/aagarwal1012/IntroViews-Flutter/blob/master/display/landscape2.png?raw=true).

  ***Note :*** If you added more than four pages in the list then there might be overlapping between `page icons` and `skip button`, so my suggestion is just make the `showSkipButton: false`.

# Documentation

### PageViewModel Class

| Dart attribute  | Datatype         | Description                                                  | Default Value |
| :---------------- | :------------------------------ | :----------------------------------------------------------- | :-----------: |
| pageColor | Color | Set color of the page. | Null      |
| mainImage | Image | Set the main image of the page. | Null      |
| title | Text | Set the title text of the page. | Null      |
| body | Text | Set the body text of the page. | Null       |
| iconImageAssetPath | String | Set the icon image asset path that would be displayed in page bubble. | Null    |
| iconColor | Color | Set the page bubble icon color. | Null |
| bubbleBackgroundColor | Color | Set the page bubble background color. | Colors.white |
| textStyle | TextStyle | set TextStyle for both title and body | title: `color: Colors.white , fontSize: 50.0` <br> body: `color: Colors.white , fontSize: 24.0` |

### IntroViewFlutter Class

| Dart attribute  | Datatype         | Description                                                  | Default Value |
| :---------------- | :------------------------------ | :----------------------------------------------------------- | :-----------: |
| pages | List<PageViewMode> | Set the pages of the intro screen. | Null      |
| onTapDoneButton | VoidCallback | Method executes on tapping done button. | Null      |
| pageButtonColor | Color | Set the color of skip and done buttons. | Colors.white |
| showSkipButton | Bool | Show the skip button at the bottom of page. | true   |
| pageButtonTextSize | Double | Set the button text size. | 18.0 |
| pageButtonFontFamily | String | Set the font of button text. | Default |
| onTapSkipButton | VoidCallback | Method executes on tapping skip button. | null |
 
For help on editing package code, view the [flutter documentation](https://flutter.io/developing-packages/).

# Want to contribute !

This is the well `documented` package. I have documented each and every method that I have used, so have a good read to the code and suggest some changes and new feature to be added in the package.  
Feel free to [open an issue](https://github.com/aagarwal1012/IntroViews-Flutter/issues).

# License
**IntroViews-Flutter** is licensed under `MIT license`.
