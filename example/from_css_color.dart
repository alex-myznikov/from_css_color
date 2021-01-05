import 'package:flutter/rendering.dart';
import 'package:from_css_color/from_css_color.dart';

// create Color from hex
var hex = fromCssColor('#fbafba'); // Color(0xFFFBAFBA)
var hexShort = fromCssColor('#fba'); // Color(0xFFFFBBAA)
var hexAlpha = fromCssColor('#fbafbafa'); // Color(0xFAFBAFBA)
var hexAlphaShort = fromCssColor('#fbaa'); // Color(0xAAFFBBAA)

// or from rgb
var rgb = fromCssColor('rgb(100, 5, 32)'); // Color(0xFF640520)
var rgbWithPercents = fromCssColor('rgb(110%, 0%, 0%)'); //Color(0xFFFF0000)
var rgba = fromCssColor('rgb(110%, 0%, 0%, 0.5)'); //Color(0x7FFF0000)

// or from hsl
var hsl = fromCssColor('hsl(100,50%,10%)'); // Color(0xFF15260C)
var hsla = fromCssColor('hsla(-120,100%,50%, .5)'); // Color(0x7F0000FF)

// and a list of X11 keywords is supported
var navy = fromCssColor('navy'); // Color(0xFF000080)
var violet = fromCssColor('violet'); // Color(0xFFEE82EE)
var transparent = fromCssColor('transparent'); // Color(0x00000000)

// convert Color to CSS string
var hexCss = Color(0xFFFBAFBA).toCssString(); // '#fbafba'
var hexShortCss = Color(0xFFBBAAFF).toCssString(); // '#baf'
var hexWithAlphaCss = Color(0xEFFFBBAA).toCssString(); // '#ffbbaaef'
var rgbCss = Color(0xFFFFFFFF)
    .toCssString(format: CssColorString.rgb); // 'rgb(255,255,255)'
var rgbaCss = Color(0x7FFFFFFF)
    .toCssString(format: CssColorString.rgb); // 'rgba(255,255,255,0.5)'

// check hex color string correctness
var checkCorrectHex = isCssColor('#fbafba'); // true
var checkIncorrectHex = isCssColor('#f'); // false

// check rgb color string correctness
var checkCorrectRgb = isCssColor('rgb(100, 5, 32)'); // true
var checkIncorrectRgb = isCssColor('rgb(100,100)'); // false

// check hsl color string correctness
var checkCorrectHsl = isCssColor('hsl(100,50%,10%)'); // true
var checkIncorrectHsl = isCssColor('hsl(100,100)'); // false

// check correctness of a list of X11 keywords is supported
var checkNavy = isCssColor('navy'); // true
var checkViolet = isCssColor('violet'); // true
var checkTransparent = isCssColor('transparent'); // true
