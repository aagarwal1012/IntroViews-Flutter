## 3.1.1
* Updated app example. Thanks @zognotadog

## 3.1.0
* Added new `pageBackground` property to the `PageViewModel`, which sets a widget as a
background of the whole page (`pageColor` has priority over this). Thanks @ride4sun
* Arguments `title`, `body` and `mainImage` are **no longer required** and can be omitted.

## 3.0.0
**Major Updates**
* Migrated to null safety.
* **Breaking Change**: Now only a single import is required:

```dart
import 'package:intro_views_flutter/intro_views_flutter.dart';
```

Other old imports from this package are now invalid and must be removed/replaced
with import above in order to solve path errors.

## 2.9.0
* Critical Bug Fix: Replacing deprecated `resizeToAvoidBottomPadding`.

## 2.8.2
* Minor bug fixes and enhancements.

## 2.8.1
* Minor bug fixes.

## 2.8.0
**Bug Fixes** 
* Add SafeArea to align title below display cutouts.
* Prevent multiple rapid clicks to overflow index bounds.

## 2.7.0
**Feature Enhancement**
* Allow title TextStyle and body TextStyle to be changed individually.
* fix: title size for iPhone 5s

## 2.6.0
* Fix problem padding top in title of pageViews.
* Background property added that can be used to add full screen image to IntroViews.

## 2.5.0
* Added Next Button to move to the next screen. Overriding doneButtonPersist.
* Added Back Button. Overrides showSkipButton starting from the second page.

## 2.4.0
**Feature Enhancement**
* Exposed the way to change the distance a user needs to drag for a full transition to occur using `fullTransition` and its default value is set to `300.0`.
* Added ability to insert a custom widget in the page bubble.
* Changed `title`, `body`, `mainImage` PageViewModel types to be more dynamic.
* Removed all `new` keywords.

## 2.3.0
**Feature Enhancement**
* Exposed columnMainAxisAlignment to change mainAxisAlignment.
* Updated Readme.

## 2.2.4
* Adjust the Scaffold in fullscreen.

## 2.2.3
* General Update.

## 2.2.2
* Added Widget testing.
* Updated Readme.


## 2.2.1
* Added feature to override Text widget styles for skip and done button.
* Added doneButtonPersist to show done button throughout the session.
* Updated Readme.

## 2.1.1
* Fixed overflow for small screen apps.

## 2.0.1
**Major Updates**
* Made intro views responsive.
* Refracting page view model.
  - Body title, expects Text Widget.
  - Main image, expects Image Widget.
  - Added TextStyle property to page view model that can be used to set styles for both title and body. 
* Added TextStyle property for page indicator buttons which overrides previous button properties.
* Updated Readme and example.

## 1.0.3

* Made intro views responsive.
* Added onTapSkipButton voidCallback.
* Updated Readme.

## 1.0.2

* Updated Readme.
* Fixed bugs.
* Fixed formatting issues.

## 1.0.1

* Updated Readme.
* Fixed static analyzers issues.
* Fixed formatting issues.

## 1.0.0

* Initial Release.
