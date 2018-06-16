<div align="center"><img src="/display/header.png"/></div>

> IntroViews is inspired by [Paper Onboarding](https://github.com/Ramotion/paper-onboarding-android) and developed with `love` from scratch. I decided to rewrite almost all the features in order to make it available to the `flutter` developers and extensible as possible.


<img src="/display/output.gif" align = "right" height = "500px">

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
 intro_views_flutter: "^1.0.0"
```

You can also reference the git repository directly if you want:

```yaml
dependencies:
 intro_views_flutter:
   git: git://github.com/aagarwal1012/IntroViews-Flutter
```

You should then run `flutter packages get` in your terminal so as to get the package.

# Usage

- `IntroViewsFlutter` class require a `list` of `PageViewModel` , and some other parameters. Refer the code below to create a PageViewModel page.  

# Documentation

#### ImageSteganography Class

| Java attribute     | Java set methods                | Description                                                  | Default Value |
| :---------------- | :------------------------------ | :----------------------------------------------------------- | :-----------: |
| Message | setMessage(...) , getMessage() | Set the value of message, Get the value of message. | Null      |
| Secret_Key | setSecret_key(...) | Set the value of secret key. | Null      |
| Image  | setImage(...) | Set the value of image.              | Null      |
| Encoded_Image | getEncoded_image() | Get the value of encoded image after text encoding. | Null       |
| Encoded | isEncoded() | Check that the encoding is over or not | false       |
| Decoded | isDecoded() | Check that the decoding is over or not. | false       |
| SecretKeyWrong | isSecretKeyWrong() | Check that the secret key provided was right or wrong but after decoding was done. | true     |

# Want to contribute !
This is the well `documented` library. I have documented each and every method that I have used, so have a good read to the code and suggest some changes and new feature to be added in the library.  
Feel free to <a href = "https://github.com/aagarwal1012/Image-Steganography-Library-Android/issues">open an issue</a>.

# License
**Image Steganography** is licensed under `MIT license`.

```
MIT License

Copyright (c) 2018 Ayush Agarwal

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

