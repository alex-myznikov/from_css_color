import 'package:from_css_color/from_css_color.dart';

// create Color from hex
var hex = fromCSSColor('#fbafba'); // Color(0xFFFBAFBA)
var hexShort = fromCSSColor('#fba'); // Color(0xFFFFBBAA)

// or from rgb
var rgb = fromCSSColor('rgb(100, 5, 32)'); // Color(0xFF640520)
var rgbWithPercents = fromCSSColor('rgb(110%, 0%, 0%)'); //Color(0xFFFF0000)
var rgba = fromCSSColor('rgb(110%, 0%, 0%, 0.5)'); //Color(0x7FFF0000)

// hsl will also be ready soon
var hsl = fromCSSColor('hsl(100,50%,10%)'); // work in progress...

// and a list of X11 keywords is supported
var navy = fromCSSColor('navy'); // Color(0xFF000080)
var violet = fromCSSColor('violet'); // Color(0xFFEE82EE)
