import 'dart:ui';

/// Color formats available to construct [Color] instance from.
enum ColorFormat {
  hex,
  rgb,
  rgba,
  hsl,
  hsla,
  keyword,
}

/// Creates [Color] instance from CSS color string according to https://drafts.csswg.org/css-color-3
Color fromCSSColor(String color) {
  color = color.trim();

  switch (_recognizeCSSColorFormat(color)) {
    case ColorFormat.hex:
      return _hexToColor(color);
    case ColorFormat.rgb:
    case ColorFormat.rgba:
      return _rgbToColor(color);
    case ColorFormat.keyword:
      return Color(colorKeywords[color]);
    default:
      return _hslToColor(color);
  }
}

ColorFormat _recognizeCSSColorFormat(String color) {
  if (color.startsWith('#'))
    return ColorFormat.hex;
  else if (color.startsWith('rgba'))
    return ColorFormat.rgba;
  else if (color.startsWith('rgb'))
    return ColorFormat.rgb;
  else if (color.startsWith('hsla'))
    return ColorFormat.hsla;
  else if (color.startsWith('hsl'))
    return ColorFormat.hsl;
  else if (colorKeywords.containsKey(color)) return ColorFormat.keyword;

  throw FormatException('Unable to recognize this CSS color format.', color);
}

/// Creates [Color] instance from hexadecimal color value.
Color _hexToColor(String color) {
  color = color.substring(1);

  if (color.length == 3)
    color = color.splitMapJoin('', onNonMatch: (m) => m * 2);
  else if (color.length != 6)
    throw FormatException(
      'Hex color string has incorrect length, only strings of 3 or 6 characters are allowed.',
      '#$color',
    );

  return Color(
    0xFF000000 +
        int.parse(
          color,
          radix: 16,
        ),
  );
}

/// Creates [Color] instance from RGB(A) color value.
Color _rgbToColor(String color) {
  var channels = _parseChannels(color);
  var result = 0xFF000000;
  var shift = 16;

  if (channels.length == 4)
    result = (_opacityChannelToHex(channels.removeLast()) << 24) & result;
  else if (channels.length != 3)
    throw FormatException(
      'Incorrect number of values in RGB color string, there must be 3 or 4 of them.',
      color,
    );

  if (_isPercentFormat(channels))
    for (var ch in channels) {
      result = (_rgbChannelPercentToHex(ch) << shift) | result;
      shift -= 8;
    }
  else
    for (var ch in channels) {
      result = (_rgbChannelNumToHex(ch) << shift) | result;
      shift -= 8;
    }

  return Color(result);
}

/// Creates [Color] instance from HSL(A) color value.
Color _hslToColor(String color) {
  var channels = _parseChannels(color);
  var result = 0xFF000000;
  var shift = 16;

  if (channels.length == 4)
    result = (_opacityChannelToHex(channels.removeLast()) << 24) & result;
  else if (channels.length != 3)
    throw FormatException(
      'Incorrect number of values in HSL color string, there must be 3 or 4 of them.',
      color,
    );

  try {
    // Translate HSL to RGB according to CSS3 draft
    final h = double.parse(channels[0]) % 360 / 360;
    final s = _parsePercent(channels[1]) / 100;
    final l = _parsePercent(channels[2]) / 100;
    final m2 = l < 0.5 ? l * (s + 1) : l + s - l * s;
    final m1 = l * 2 - m2;
    final hexChannels = [
      _hueToRGB(m1, m2, h + 1 / 3),
      _hueToRGB(m1, m2, h),
      _hueToRGB(m1, m2, h - 1 / 3),
    ];

    for (var ch in hexChannels) {
      result = (ch << shift) | result;
      shift -= 8;
    }

    return Color(result);
  } on FormatException catch (e) {
    throw FormatException('Incorrect format of HSL color string.', '${e.message} ${e.source}');
  }
}

/// Parses channels from RGBA/HSLA string representation.
List<String> _parseChannels(color) {
  return color.substring(color.indexOf('(') + 1, color.length - 1).split(',');
}

/// Parses numeric value from string [percent] representation.
num _parsePercent(String percent) {
  return (double.parse(percent.substring(0, percent.length - 1)).clamp(0, 100));
}

/// Converts RGB channel numeric [value] to hexadecimal integer form.
int _rgbChannelNumToHex(String value) {
  return double.parse(value).clamp(0, 255).floor() & 0xFF;
}

/// Converts RGB channel percentage [value] to hexadecimal integer form.
int _rgbChannelPercentToHex(String value) {
  return (_parsePercent(value) * 255 / 100).floor() & 0xFF;
}

/// Converts RGBA/HSLA opacity channel [value] to hexadecimal integer form.
int _opacityChannelToHex(String value) {
  return (double.parse(value).clamp(0, 1) * 255).floor() & 0xFF;
}

/// Converts hue parameters of HSL to RGB channel hexadecimal integer form.
int _hueToRGB(num m1, num m2, num h) {
  int result;

  if (h < 0)
    h = h + 1;
  else if (h > 1) h = h - 1;

  if (h * 6 < 1)
    result = ((m1 + (m2 - m1) * h * 6) * 255).floor();
  else if (h * 2 < 1)
    result = (m2 * 255).floor();
  else if (h * 3 < 2)
    result = ((m1 + (m2 - m1) * (2 / 3 - h) * 6) * 255).floor();
  else
    result = (m1 * 255).floor();

  return result & 0xFF;
}

/// Returns `true` if all [rgb] channels are in percent format, `false` in non of them, throws otherwise.
bool _isPercentFormat(List<String> rgb) {
  if (rgb.every((ch) => ch.endsWith('%')))
    return true;
  else if (rgb.every((ch) => !ch.endsWith('%')))
    return false;
  else
    throw FormatException(
      'Mixing integer and percentage values in the same RGB color definition is forbidden.',
      rgb.toString(),
    );
}

// A map of X11 color keywords and their 8-digit hexadecimal forms.
Map<String, int> colorKeywords = {
  "transparent": 0x00000000,
  "aliceblue": 0xFFF0F8FF,
  "antiquewhite": 0xFFFAEBD7,
  "aqua": 0xFF00FFFF,
  "aquamarine": 0xFF7FFFD4,
  "azure": 0xFFF0FFFF,
  "beige": 0xFFF5F5DC,
  "bisque": 0xFFFFE4C4,
  "black": 0xFF000000,
  "blanchedalmond": 0xFFFFEBCD,
  "blue": 0xFF0000FF,
  "blueviolet": 0xFF8A2BE2,
  "brown": 0xFFA52A2A,
  "burlywood": 0xFFDEB887,
  "cadetblue": 0xFF5F9EA0,
  "chartreuse": 0xFF7FFF00,
  "chocolate": 0xFFD2691E,
  "coral": 0xFFFF7F50,
  "cornflowerblue": 0xFF6495ED,
  "cornsilk": 0xFFFFF8DC,
  "crimson": 0xFFDC143C,
  "cyan": 0xFF00FFFF,
  "darkblue": 0xFF00008B,
  "darkcyan": 0xFF008B8B,
  "darkgoldenrod": 0xFFB8860B,
  "darkgray": 0xFFA9A9A9,
  "darkgreen": 0xFF006400,
  "darkgrey": 0xFFA9A9A9,
  "darkkhaki": 0xFFBDB76B,
  "darkmagenta": 0xFF8B008B,
  "darkolivegreen": 0xFF556B2F,
  "darkorange": 0xFFFF8C00,
  "darkorchid": 0xFF9932CC,
  "darkred": 0xFF8B0000,
  "darksalmon": 0xFFE9967A,
  "darkseagreen": 0xFF8FBC8F,
  "darkslateblue": 0xFF483D8B,
  "darkslategray": 0xFF2F4F4F,
  "darkslategrey": 0xFF2F4F4F,
  "darkturquoise": 0xFF00CED1,
  "darkviolet": 0xFF9400D3,
  "deeppink": 0xFFFF1493,
  "deepskyblue": 0xFF00BFFF,
  "dimgray": 0xFF696969,
  "dimgrey": 0xFF696969,
  "dodgerblue": 0xFF1E90FF,
  "firebrick": 0xFFB22222,
  "floralwhite": 0xFFFFFAF0,
  "forestgreen": 0xFF228B22,
  "fuchsia": 0xFFFF00FF,
  "gainsboro": 0xFFDCDCDC,
  "ghostwhite": 0xFFF8F8FF,
  "gold": 0xFFFFD700,
  "goldenrod": 0xFFDAA520,
  "gray": 0xFF808080,
  "green": 0xFF008000,
  "greenyellow": 0xFFADFF2F,
  "grey": 0xFF808080,
  "honeydew": 0xFFF0FFF0,
  "hotpink": 0xFFFF69B4,
  "indianred": 0xFFCD5C5C,
  "indigo": 0xFF4B0082,
  "ivory": 0xFFFFFFF0,
  "khaki": 0xFFF0E68C,
  "lavender": 0xFFE6E6FA,
  "lavenderblush": 0xFFFFF0F5,
  "lawngreen": 0xFF7CFC00,
  "lemonchiffon": 0xFFFFFACD,
  "lightblue": 0xFFADD8E6,
  "lightcoral": 0xFFF08080,
  "lightcyan": 0xFFE0FFFF,
  "lightgoldenrodyellow": 0xFFFAFAD2,
  "lightgray": 0xFFD3D3D3,
  "lightgreen": 0xFF90EE90,
  "lightgrey": 0xFFD3D3D3,
  "lightpink": 0xFFFFB6C1,
  "lightsalmon": 0xFFFFA07A,
  "lightseagreen": 0xFF20B2AA,
  "lightskyblue": 0xFF87CEFA,
  "lightslategray": 0xFF778899,
  "lightslategrey": 0xFF778899,
  "lightsteelblue": 0xFFB0C4DE,
  "lightyellow": 0xFFFFFFE0,
  "lime": 0xFF00FF00,
  "limegreen": 0xFF32CD32,
  "linen": 0xFFFAF0E6,
  "magenta": 0xFFFF00FF,
  "maroon": 0xFF800000,
  "mediumaquamarine": 0xFF66CDAA,
  "mediumblue": 0xFF0000CD,
  "mediumorchid": 0xFFBA55D3,
  "mediumpurple": 0xFF9370DB,
  "mediumseagreen": 0xFF3CB371,
  "mediumslateblue": 0xFF7B68EE,
  "mediumspringgreen": 0xFF00FA9A,
  "mediumturquoise": 0xFF48D1CC,
  "mediumvioletred": 0xFFC71585,
  "midnightblue": 0xFF191970,
  "mintcream": 0xFFF5FFFA,
  "mistyrose": 0xFFFFE4E1,
  "moccasin": 0xFFFFE4B5,
  "navajowhite": 0xFFFFDEAD,
  "navy": 0xFF000080,
  "oldlace": 0xFFFDF5E6,
  "olive": 0xFF808000,
  "olivedrab": 0xFF6B8E23,
  "orange": 0xFFFFA500,
  "orangered": 0xFFFF4500,
  "orchid": 0xFFDA70D6,
  "palegoldenrod": 0xFFEEE8AA,
  "palegreen": 0xFF98FB98,
  "paleturquoise": 0xFFAFEEEE,
  "palevioletred": 0xFFDB7093,
  "papayawhip": 0xFFFFEFD5,
  "peachpuff": 0xFFFFDAB9,
  "peru": 0xFFCD853F,
  "pink": 0xFFFFC0CB,
  "plum": 0xFFDDA0DD,
  "powderblue": 0xFFB0E0E6,
  "purple": 0xFF800080,
  "red": 0xFFFF0000,
  "rosybrown": 0xFFBC8F8F,
  "royalblue": 0xFF4169E1,
  "saddlebrown": 0xFF8B4513,
  "salmon": 0xFFFA8072,
  "sandybrown": 0xFFF4A460,
  "seagreen": 0xFF2E8B57,
  "seashell": 0xFFFFF5EE,
  "sienna": 0xFFA0522D,
  "silver": 0xFFC0C0C0,
  "skyblue": 0xFF87CEEB,
  "slateblue": 0xFF6A5ACD,
  "slategray": 0xFF708090,
  "slategrey": 0xFF708090,
  "snow": 0xFFFFFAFA,
  "springgreen": 0xFF00FF7F,
  "steelblue": 0xFF4682B4,
  "tan": 0xFFD2B48C,
  "teal": 0xFF008080,
  "thistle": 0xFFD8BFD8,
  "tomato": 0xFFFF6347,
  "turquoise": 0xFF40E0D0,
  "violet": 0xFFEE82EE,
  "wheat": 0xFFF5DEB3,
  "white": 0xFFFFFFFF,
  "whitesmoke": 0xFFF5F5F5,
  "yellow": 0xFFFFFF00,
  "yellowgreen": 0xFF9ACD32,
};
