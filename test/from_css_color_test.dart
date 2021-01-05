import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:from_css_color/from_css_color.dart';

void main() {
  group('toCssColor:', () {
    test('should convert Color instance to CSS hex string by default', () {
      expect(fromCSSColor('#fbafba').toCssString(), equals('#fbafba'));
      expect(fromCSSColor('#f23b0c').toCssString(), equals('#f23b0c'));
      expect(fromCSSColor('#ffbbac').toCssString(), equals('#ffbbac'));
      expect(fromCSSColor('#fbafbacc').toCssString(), equals('#fbafbacc'));
      expect(fromCSSColor('#ffbbaa').toCssString(), equals('#fba'));
      expect(fromCSSColor('#ffbbaacd').toCssString(), equals('#ffbbaacd'));
      expect(fromCSSColor('#fba').toCssString(), equals('#fba'));
      expect(fromCSSColor('  #fba    ').toCssString(), equals('#fba'));
      expect(fromCSSColor('#efba').toCssString(), equals('#efba'));
      expect(fromCSSColor('#efbf').toCssString(), equals('#efb'));
      expect(Color(0xFFBBAA).toCssString(), equals('#fba0'));
      expect(Color(0xFFBBAAFF).toCssString(), equals('#baf'));
      expect(Color(0xEFFFBBAA).toCssString(), equals('#ffbbaaef'));
      expect(Color(0xFFFBAFBA).toCssString(), equals('#fbafba'));
      expect(Color(0).toCssString(), equals('#0000'));
      expect(Color(0xF).toCssString(), equals('#00000f00'));
    });

    test('should convert Color instance to RGB/RGBA string', () {
      expect(fromCSSColor('rgb(0,0,0)').toCssString(format: CssColorString.rgb),
          equals('rgb(0,0,0)'));
      expect(
          fromCSSColor('rgba(0%,0%,0%)').toCssString(format: CssColorString.rgb),
          equals('rgb(0,0,0)'));
      expect(
          fromCSSColor('rgb(255,255,255)')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(255,255,255)'));
      expect(
          fromCSSColor('rgb(255,255,255,0.5)')
              .toCssString(format: CssColorString.rgb),
          equals('rgba(255,255,255,0.5)'));
      expect(
          fromCSSColor('rgba(100%,100%,100%)')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(255,255,255)'));
      expect(
          fromCSSColor('rgb(100,5,32)').toCssString(format: CssColorString.rgb),
          equals('rgb(100,5,32)'));
      expect(
          fromCSSColor('rgba(2.6,0.4,265.5)')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(2,0,255)'));
      expect(
          fromCSSColor('rgba(255,-10,0) ')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(255,0,0)'));
      expect(
          fromCSSColor('rgba(0%,0%,0%,0)')
              .toCssString(format: CssColorString.rgb),
          equals('rgba(0,0,0,0)'));
      expect(Color(0xFFFFFFFF).toCssString(format: CssColorString.rgb),
          equals('rgb(255,255,255)'));
      expect(Color(0x7FFFFFFF).toCssString(format: CssColorString.rgb),
          equals('rgba(255,255,255,0.5)'));
    });
  });

  group('fromCSSColor:', () {
    test('should create from correct 3 and 6 character hex values', () {
      expect(fromCSSColor('#fbafba'), equals(Color(0xFFFBAFBA)));
      expect(fromCSSColor('#f23b0c'), equals(Color(0xFFF23B0C)));
      expect(fromCSSColor('#fba'), equals(Color(0xFFFFBBAA)));
      expect(fromCSSColor('  #fba    '), equals(Color(0xFFFFBBAA)));
    });

    test('should create from correct 4 and 8 character hex values', () {
      expect(fromCSSColor('#fbafbafa'), equals(Color(0xFAFBAFBA)));
      expect(fromCSSColor('#f23b0c00'), equals(Color(0x00F23B0C)));
      expect(fromCSSColor('#fbaa'), equals(Color(0xAAFFBBAA)));
      expect(fromCSSColor('#fbaf'), equals(Color(0xFFFFBBAA)));
      expect(fromCSSColor('  #fbac    '), equals(Color(0xCCFFBBAA)));
    });

    test('should throw format exception on incorrect hex values', () {
      expect(() => fromCSSColor('#fbafa'), throwsFormatException);
      expect(() => fromCSSColor('#f'), throwsFormatException);
      expect(() => fromCSSColor('#'), throwsFormatException);
      expect(() => fromCSSColor('3ac57b'), throwsFormatException);
      expect(() => fromCSSColor('#hba'), throwsFormatException);
      expect(() => fromCSSColor('#1l4x5d'), throwsFormatException);
      expect(() => fromCSSColor('#1l4x5dd'), throwsFormatException);
      expect(() => fromCSSColor('#1b4a5d2x'), throwsFormatException);
      expect(() => fromCSSColor('#1d4c5daab'), throwsFormatException);
      expect(() => fromCSSColor('#1d4 c5d'), throwsFormatException);
    });

    test('should create from correct rgb/rgba values', () {
      expect(fromCSSColor('rgb(0,0,0)'), equals(Color(0xFF000000)));
      expect(fromCSSColor('rgba(0%,0%,0%)'), equals(Color(0xFF000000)));
      expect(fromCSSColor('rgb(255,255,255)'), equals(Color(0xFFFFFFFF)));
      expect(fromCSSColor('rgba(100%,100%,100%)'), equals(Color(0xFFFFFFFF)));
      expect(fromCSSColor('rgb(100,5,32)'), equals(Color(0xFF640520)));
      expect(fromCSSColor('rgba(2.5,0.4,265.5)'), equals(Color(0xFF0200FF)));
      expect(fromCSSColor('rgb(300,0,0)'), equals(Color(0xFFFF0000)));
      expect(fromCSSColor('rgba(255,-10,0) '), equals(Color(0xFFFF0000)));
      expect(fromCSSColor('rgb(110%,0%,0%)'), equals(Color(0xFFFF0000)));
      expect(fromCSSColor('rgb(0,0,0,0)'), equals(Color(0x00000000)));
      expect(fromCSSColor('rgba(0%,0%,0%,0)'), equals(Color(0x00000000)));
      expect(fromCSSColor('  rgb(0,0,0,1)'), equals(Color(0xFF000000)));
      expect(fromCSSColor('rgba(255,255,255,0)'), equals(Color(0x00FFFFFF)));
      expect(fromCSSColor('rgb(100%,100%,100%,1)'), equals(Color(0xFFFFFFFF)));
      expect(fromCSSColor('rgba(100,5,32,0.5)'), equals(Color(0x7F640520)));
      expect(
          fromCSSColor('rgb(2.5,0.4,265.5,0.2222)'), equals(Color(0x380200FF)));
      expect(fromCSSColor('rgba(300,0,0,-1)'), equals(Color(0x00FF0000)));
      expect(fromCSSColor('rgb(255,-10,0,1000)'), equals(Color(0xFFFF0000)));
      expect(fromCSSColor('rgba(110%,0%,0%)'), equals(Color(0xFFFF0000)));
    });

    test('should throw format exception on incorrect rgb/rgba values', () {
      expect(() => fromCSSColor('rgba(0%,0,0)'), throwsFormatException);
      expect(() => fromCSSColor('rgb(q,0%,0%)'), throwsFormatException);
      expect(() => fromCSSColor('rgba(q,r,zcv)'), throwsFormatException);
      expect(() => fromCSSColor('rgb(100,100)'), throwsFormatException);
      expect(() => fromCSSColor('rgba(0%)'), throwsFormatException);
      expect(() => fromCSSColor('rgb(0%,10%,5%,100%)'), throwsFormatException);
      expect(() => fromCSSColor('rgba(0%,0,0,100%)'), throwsFormatException);
      expect(() => fromCSSColor('rgb(q,0%,0%,q)'), throwsFormatException);
      expect(() => fromCSSColor('rgb()'), throwsFormatException);
      expect(() => fromCSSColor('rgba(((%^&*^(&*))'), throwsFormatException);
      expect(() => fromCSSColor('rgb(-1000)'), throwsFormatException);
      expect(() => fromCSSColor('rgba(1,10,5,)'), throwsFormatException);
    });

    test('should create from extended color keywords', () {
      expect(fromCSSColor('darkgray'), equals(Color(0xFFA9A9A9)));
      expect(fromCSSColor('bisque'), equals(Color(0xFFFFE4C4)));
      expect(fromCSSColor('mediumslateblue'), equals(Color(0xFF7B68EE)));
      expect(fromCSSColor('navy  '), equals(Color(0xFF000080)));
      expect(fromCSSColor('violet'), equals(Color(0xFFEE82EE)));
    });

    test('should create from "transparent" color keyword', () {
      expect(fromCSSColor('transparent'), equals(Color(0x00000000)));
    });

    test(
        'should throw format exception if the provided color format is unknown',
        () {
      expect(() => fromCSSColor('strangecolor'), throwsFormatException);
      expect(() => fromCSSColor('12'), throwsFormatException);
      expect(() => fromCSSColor(''), throwsFormatException);
    });

    test('should create from correct hsl/hsla values', () {
      expect(fromCSSColor('hsl(0,0%,0%)'), equals(Color(0xFF000000)));
      expect(fromCSSColor('hsla(0,0%,0%,0)'), equals(Color(0x00000000)));
      expect(fromCSSColor('hsl(0,100%,0%)'), equals(Color(0xFF000000)));
      expect(fromCSSColor('hsl(0,100%,50%)'), equals(Color(0xFFFF0000)));
      expect(fromCSSColor('hsl(360,100%,50%)'), equals(Color(0xFFFF0000)));
      expect(fromCSSColor('hsl(720,100%,50%)'), equals(Color(0xFFFF0000)));
      expect(fromCSSColor('hsl(120,100%,50%)'), equals(Color(0xFF00FF00)));
      expect(fromCSSColor('hsl(240,100%,50%)'), equals(Color(0xFF0000FF)));
      expect(fromCSSColor('hsl(-120,100%,50%)'), equals(Color(0xFF0000FF)));
      expect(
          fromCSSColor('hsla(-120,100%,50%, .5)'), equals(Color(0x7F0000FF)));
      expect(fromCSSColor('hsl(123,0%,100%)'), equals(Color(0xFFFFFFFF)));
      expect(fromCSSColor('hsl(-120,100%,50%,0)'), equals(Color(0x000000FF)));
      expect(fromCSSColor('hsl(-120,0%,50%)'), equals(Color(0xFF7F7F7F)));
      expect(fromCSSColor('hsl(100,50%,10%)'), equals(Color(0xFF15260C)));
      expect(fromCSSColor('hsl(100,54.99%,10.9%)'), equals(Color(0xFF162b0c)));
      expect(fromCSSColor('hsl(343, 90%, 21%)'), equals(Color(0xFF650520)));
      expect(fromCSSColor('hsla(100,100%,100%)'), equals(Color(0xFFFFFFFF)));
      expect(fromCSSColor('hsl(0,110%,50%)'), equals(Color(0xFFFF0000)));
      expect(fromCSSColor('hsl(0,-10%,50%)'), equals(Color(0xFF7F7F7F)));
      expect(fromCSSColor('  hsl(0,0%,0%,1)'), equals(Color(0xFF000000)));
    });

    test('should throw format exception on incorrect hsl/hsla values', () {
      expect(() => fromCSSColor('hsla(0%,0,0)'), throwsFormatException);
      expect(() => fromCSSColor('hsl(q,0%,0%)'), throwsFormatException);
      expect(() => fromCSSColor('hsla(q,r,zcv)'), throwsFormatException);
      expect(() => fromCSSColor('hsl(100,100)'), throwsFormatException);
      expect(() => fromCSSColor('hsla(0%)'), throwsFormatException);
      expect(() => fromCSSColor('hsl(0%,10%,5%,100%)'), throwsFormatException);
      expect(() => fromCSSColor('hsla(0%,0,0,100%)'), throwsFormatException);
      expect(() => fromCSSColor('hsl(q,0%,0%,q)'), throwsFormatException);
      expect(() => fromCSSColor('hsl()'), throwsFormatException);
      expect(() => fromCSSColor('hsla(((%^&*^(&*))'), throwsFormatException);
      expect(() => fromCSSColor('hsl(-1000)'), throwsFormatException);
      expect(() => fromCSSColor('hsla(1,10,5,)'), throwsFormatException);
    });
  });

  group('isCSSColor:', () {
    test('should return true for correct 3 and 6 character hex values', () {
      expect(isCSSColor('#fbafba'), equals(true));
      expect(isCSSColor('#f23b0c'), equals(true));
      expect(isCSSColor('#fba'), equals(true));
      expect(isCSSColor('  #fba    '), equals(true));
    });

    test('should return true for correct 4 and 8 character hex values', () {
      expect(isCSSColor('#fbafbafa'), equals(true));
      expect(isCSSColor('#f23b0c00'), equals(true));
      expect(isCSSColor('#fbaa'), equals(true));
      expect(isCSSColor('#fbaf'), equals(true));
      expect(isCSSColor('  #fbac    '), equals(true));
    });

    test('should return false for incorrect hex values', () {
      expect(isCSSColor('#fbafa'), equals(false));
      expect(isCSSColor('#f'), equals(false));
      expect(isCSSColor('#'), equals(false));
      expect(isCSSColor('3ac57b'), equals(false));
      expect(isCSSColor('#hba'), equals(false));
      expect(isCSSColor('#1l4x5d'), equals(false));
      expect(isCSSColor('#1l4x5dd'), equals(false));
      expect(isCSSColor('#1b4a5d2x'), equals(false));
      expect(isCSSColor('#1d4c5daab'), equals(false));
      expect(isCSSColor('#1d4 c5d'), equals(false));
    });

    test('should return true for correct rgb/rgba values', () {
      expect(isCSSColor('rgb(0,0,0)'), equals(true));
      expect(isCSSColor('rgba(0%,0%,0%)'), equals(true));
      expect(isCSSColor('rgb(255,255,255)'), equals(true));
      expect(isCSSColor('rgba(100%,100%,100%)'), equals(true));
      expect(isCSSColor('rgb(100,5,32)'), equals(true));
      expect(isCSSColor('rgba(2.5,0.4,265.5)'), equals(true));
      expect(isCSSColor('rgb(300,0,0)'), equals(true));
      expect(isCSSColor('rgba(255,-10,0) '), equals(true));
      expect(isCSSColor('rgb(110%,0%,0%)'), equals(true));
      expect(isCSSColor('rgb(0,0,0,0)'), equals(true));
      expect(isCSSColor('rgba(0%,0%,0%,0)'), equals(true));
      expect(isCSSColor('  rgb(0,0,0,1)'), equals(true));
      expect(isCSSColor('rgba(255,255,255,0)'), equals(true));
      expect(isCSSColor('rgb(100%,100%,100%,1)'), equals(true));
      expect(isCSSColor('rgba(100,5,32,0.5)'), equals(true));
      expect(isCSSColor('rgb(2.5,0.4,265.5,0.2222)'), equals(true));
      expect(isCSSColor('rgba(300,0,0,-1)'), equals(true));
      expect(isCSSColor('rgb(255,-10,0,1000)'), equals(true));
      expect(isCSSColor('rgba(110%,0%,0%)'), equals(true));
    });

    test('should return false for incorrect rgb/rgba values', () {
      expect(isCSSColor('rgba(0%,0,0)'), equals(false));
      expect(isCSSColor('rgb(q,0%,0%)'), equals(false));
      expect(isCSSColor('rgba(q,r,zcv)'), equals(false));
      expect(isCSSColor('rgb(100,100)'), equals(false));
      expect(isCSSColor('rgba(0%)'), equals(false));
      expect(isCSSColor('rgb(0%,10%,5%,100%)'), equals(false));
      expect(isCSSColor('rgba(0%,0,0,100%)'), equals(false));
      expect(isCSSColor('rgb(q,0%,0%,q)'), equals(false));
      expect(isCSSColor('rgb()'), equals(false));
      expect(isCSSColor('rgba(((%^&*^(&*))'), equals(false));
      expect(isCSSColor('rgb(-1000)'), equals(false));
      expect(isCSSColor('rgba(1,10,5,)'), equals(false));
    });

    test('should return true for extended color keywords', () {
      expect(isCSSColor('darkgray'), equals(true));
      expect(isCSSColor('bisque'), equals(true));
      expect(isCSSColor('mediumslateblue'), equals(true));
      expect(isCSSColor('navy  '), equals(true));
      expect(isCSSColor('violet'), equals(true));
    });

    test('should return true from "transparent" color keyword', () {
      expect(isCSSColor('transparent'), equals(true));
    });

    test('should return false if the provided color format is unknown', () {
      expect(isCSSColor('strangecolor'), equals(false));
      expect(isCSSColor('12'), equals(false));
      expect(isCSSColor(''), equals(false));
    });

    test('should return true for correct hsl/hsla values', () {
      expect(isCSSColor('hsl(0,0%,0%)'), equals(true));
      expect(isCSSColor('hsla(0,0%,0%,0)'), equals(true));
      expect(isCSSColor('hsl(0,100%,0%)'), equals(true));
      expect(isCSSColor('hsl(0,100%,50%)'), equals(true));
      expect(isCSSColor('hsl(360,100%,50%)'), equals(true));
      expect(isCSSColor('hsl(720,100%,50%)'), equals(true));
      expect(isCSSColor('hsl(120,100%,50%)'), equals(true));
      expect(isCSSColor('hsl(240,100%,50%)'), equals(true));
      expect(isCSSColor('hsl(-120,100%,50%)'), equals(true));
      expect(isCSSColor('hsla(-120,100%,50%, .5)'), equals(true));
      expect(isCSSColor('hsl(123,0%,100%)'), equals(true));
      expect(isCSSColor('hsl(-120,100%,50%,0)'), equals(true));
      expect(isCSSColor('hsl(-120,0%,50%)'), equals(true));
      expect(isCSSColor('hsl(100,50%,10%)'), equals(true));
      expect(isCSSColor('hsl(100,54.99%,10.9%)'), equals(true));
      expect(isCSSColor('hsl(343, 90%, 21%)'), equals(true));
      expect(isCSSColor('hsla(100,100%,100%)'), equals(true));
      expect(isCSSColor('hsl(0,110%,50%)'), equals(true));
      expect(isCSSColor('hsl(0,-10%,50%)'), equals(true));
      expect(isCSSColor('  hsl(0,0%,0%,1)'), equals(true));
    });

    test('should return false for incorrect hsl/hsla values', () {
      expect(isCSSColor('hsla(0%,0,0)'), equals(false));
      expect(isCSSColor('hsl(q,0%,0%)'), equals(false));
      expect(isCSSColor('hsla(q,r,zcv)'), equals(false));
      expect(isCSSColor('hsl(100,100)'), equals(false));
      expect(isCSSColor('hsla(0%)'), equals(false));
      expect(isCSSColor('hsl(0%,10%,5%,100%)'), equals(false));
      expect(isCSSColor('hsla(0%,0,0,100%)'), equals(false));
      expect(isCSSColor('hsl(q,0%,0%,q)'), equals(false));
      expect(isCSSColor('hsl()'), equals(false));
      expect(isCSSColor('hsla(((%^&*^(&*))'), equals(false));
      expect(isCSSColor('hsl(-1000)'), equals(false));
      expect(isCSSColor('hsla(1,10,5,)'), equals(false));
    });
  });
}
