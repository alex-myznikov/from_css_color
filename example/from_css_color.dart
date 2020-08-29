import 'package:from_css_color/from_css_color.dart';

// create Color from hex
var hex = fromCSSColor('#fbafba'); // Color(0xFFFBAFBA)
var hexShort = fromCSSColor('#fba'); // Color(0xFFFFBBAA)
var hexAlpha = fromCSSColor('#fbafbafa'); // Color(0xFAFBAFBA)
var hexAlphaShort = fromCSSColor('#fbaa'); // Color(0xAAFFBBAA)

// or from rgb
var rgb = fromCSSColor('rgb(100, 5, 32)'); // Color(0xFF640520)
var rgbWithPercents = fromCSSColor('rgb(110%, 0%, 0%)'); //Color(0xFFFF0000)
var rgba = fromCSSColor('rgb(110%, 0%, 0%, 0.5)'); //Color(0x7FFF0000)

// or from hsl
var hsl = fromCSSColor('hsl(100,50%,10%)'); // Color(0xFF15260C)
var hsla = fromCSSColor('hsla(-120,100%,50%, .5)'); // Color(0x7F0000FF)

// and a list of X11 keywords is supported
var navy = fromCSSColor('navy'); // Color(0xFF000080)
var violet = fromCSSColor('violet'); // Color(0xFFEE82EE)
var transparent = fromCSSColor('transparent'); // Color(0x00000000)
