# From CSS Color

A package that creates Color instances from CSS color strings according to https://drafts.csswg.org/css-color-3.
Hex, RGB(A), HSL(A) and X11 keywords are supported.

## Usage

To use this plugin, add `from_css_color` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Example

Import the library.

```dart
import 'package:from_css_color/from_css_color.dart';
```

And use it anywhere you want to create a Color from CSS color definition format:

```dart
Container(
  color: fromCSSColor('#ff00aa'),
  // ...
)
```

Visit examples for more details.
