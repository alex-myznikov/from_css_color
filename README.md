# From CSS Color

A package that creates Flutter Color instances from CSS color strings according to [CSS Color Module Level 3](https://drafts.csswg.org/css-color-3).
Hex, RGB(A), HSL(A) and X11 keywords are supported.

Backwards conversion from Color to CSS color string is also available with `toCssColor()` extention method.

## Usage

To use this plugin, add `from_css_color` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Example

Import the library.

```dart
import 'package:from_css_color/from_css_color.dart';
```

Use it anywhere you want to create a Color from CSS color definition format:

```dart
Container(
  color: fromCssColor('#ff00aa'),
  // ...
)

Container(
  color: fromCssColor('rgb(100, 5, 32)'),
  // ...
)
```

Convert Color back to CSS string:

```dart
final color = const Color(0xFFFBAFBA);

color.toCssString(); // '#fbafba'
```

Check CSS color string correctness:

```dart
isCssColor('#ff00aa'); // true
```

Visit examples for more details.
