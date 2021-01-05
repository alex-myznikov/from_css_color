import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:from_css_color/from_css_color.dart';

void main() {
  group('toCssColor:', () {
    test('should convert Color instance to CSS hex string by default', () {
      expect(fromCssColor('#fbafba').toCssString(), equals('#fbafba'));
      expect(fromCssColor('#f23b0c').toCssString(), equals('#f23b0c'));
      expect(fromCssColor('#ffbbac').toCssString(), equals('#ffbbac'));
      expect(fromCssColor('#fbafbacc').toCssString(), equals('#fbafbacc'));
      expect(fromCssColor('#ffbbaa').toCssString(), equals('#fba'));
      expect(fromCssColor('#ffbbaacd').toCssString(), equals('#ffbbaacd'));
      expect(fromCssColor('#fba').toCssString(), equals('#fba'));
      expect(fromCssColor('  #fba    ').toCssString(), equals('#fba'));
      expect(fromCssColor('#efba').toCssString(), equals('#efba'));
      expect(fromCssColor('#efbf').toCssString(), equals('#efb'));
      expect(Color(0xFFBBAA).toCssString(), equals('#fba0'));
      expect(Color(0xFFBBAAFF).toCssString(), equals('#baf'));
      expect(Color(0xEFFFBBAA).toCssString(), equals('#ffbbaaef'));
      expect(Color(0xFFFBAFBA).toCssString(), equals('#fbafba'));
      expect(Color(0).toCssString(), equals('#0000'));
      expect(Color(0xF).toCssString(), equals('#00000f00'));
    });

    test('should convert Color instance to RGB/RGBA string', () {
      expect(fromCssColor('rgb(0,0,0)').toCssString(format: CssColorString.rgb),
          equals('rgb(0,0,0)'));
      expect(
          fromCssColor('rgba(0%,0%,0%)')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(0,0,0)'));
      expect(
          fromCssColor('rgb(255,255,255)')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(255,255,255)'));
      expect(
          fromCssColor('rgb(255,255,255,0.5)')
              .toCssString(format: CssColorString.rgb),
          equals('rgba(255,255,255,0.5)'));
      expect(
          fromCssColor('rgba(100%,100%,100%)')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(255,255,255)'));
      expect(
          fromCssColor('rgb(100,5,32)').toCssString(format: CssColorString.rgb),
          equals('rgb(100,5,32)'));
      expect(
          fromCssColor('rgba(2.6,0.4,265.5)')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(2,0,255)'));
      expect(
          fromCssColor('rgba(255,-10,0) ')
              .toCssString(format: CssColorString.rgb),
          equals('rgb(255,0,0)'));
      expect(
          fromCssColor('rgba(0%,0%,0%,0)')
              .toCssString(format: CssColorString.rgb),
          equals('rgba(0,0,0,0)'));
      expect(Color(0xFFFFFFFF).toCssString(format: CssColorString.rgb),
          equals('rgb(255,255,255)'));
      expect(Color(0x7FFFFFFF).toCssString(format: CssColorString.rgb),
          equals('rgba(255,255,255,0.5)'));
    });
  });

  group('fromCssColor:', () {
    test('should create from correct 3 and 6 character hex values', () {
      expect(fromCssColor('#fbafba'), equals(Color(0xFFFBAFBA)));
      expect(fromCssColor('#f23b0c'), equals(Color(0xFFF23B0C)));
      expect(fromCssColor('#fba'), equals(Color(0xFFFFBBAA)));
      expect(fromCssColor('  #fba    '), equals(Color(0xFFFFBBAA)));
    });

    test('should create from correct 4 and 8 character hex values', () {
      expect(fromCssColor('#fbafbafa'), equals(Color(0xFAFBAFBA)));
      expect(fromCssColor('#f23b0c00'), equals(Color(0x00F23B0C)));
      expect(fromCssColor('#fbaa'), equals(Color(0xAAFFBBAA)));
      expect(fromCssColor('#fbaf'), equals(Color(0xFFFFBBAA)));
      expect(fromCssColor('  #fbac    '), equals(Color(0xCCFFBBAA)));
    });

    test('should throw format exception on incorrect hex values', () {
      expect(() => fromCssColor('#fbafa'), throwsFormatException);
      expect(() => fromCssColor('#f'), throwsFormatException);
      expect(() => fromCssColor('#'), throwsFormatException);
      expect(() => fromCssColor('3ac57b'), throwsFormatException);
      expect(() => fromCssColor('#hba'), throwsFormatException);
      expect(() => fromCssColor('#1l4x5d'), throwsFormatException);
      expect(() => fromCssColor('#1l4x5dd'), throwsFormatException);
      expect(() => fromCssColor('#1b4a5d2x'), throwsFormatException);
      expect(() => fromCssColor('#1d4c5daab'), throwsFormatException);
      expect(() => fromCssColor('#1d4 c5d'), throwsFormatException);
    });

    test('should create from correct rgb/rgba values', () {
      expect(fromCssColor('rgb(0,0,0)'), equals(Color(0xFF000000)));
      expect(fromCssColor('rgba(0%,0%,0%)'), equals(Color(0xFF000000)));
      expect(fromCssColor('rgb(255,255,255)'), equals(Color(0xFFFFFFFF)));
      expect(fromCssColor('rgba(100%,100%,100%)'), equals(Color(0xFFFFFFFF)));
      expect(fromCssColor('rgb(100,5,32)'), equals(Color(0xFF640520)));
      expect(fromCssColor('rgba(2.5,0.4,265.5)'), equals(Color(0xFF0200FF)));
      expect(fromCssColor('rgb(300,0,0)'), equals(Color(0xFFFF0000)));
      expect(fromCssColor('rgba(255,-10,0) '), equals(Color(0xFFFF0000)));
      expect(fromCssColor('rgb(110%,0%,0%)'), equals(Color(0xFFFF0000)));
      expect(fromCssColor('rgb(0,0,0,0)'), equals(Color(0x00000000)));
      expect(fromCssColor('rgba(0%,0%,0%,0)'), equals(Color(0x00000000)));
      expect(fromCssColor('  rgb(0,0,0,1)'), equals(Color(0xFF000000)));
      expect(fromCssColor('rgba(255,255,255,0)'), equals(Color(0x00FFFFFF)));
      expect(fromCssColor('rgb(100%,100%,100%,1)'), equals(Color(0xFFFFFFFF)));
      expect(fromCssColor('rgba(100,5,32,0.5)'), equals(Color(0x7F640520)));
      expect(
          fromCssColor('rgb(2.5,0.4,265.5,0.2222)'), equals(Color(0x380200FF)));
      expect(fromCssColor('rgba(300,0,0,-1)'), equals(Color(0x00FF0000)));
      expect(fromCssColor('rgb(255,-10,0,1000)'), equals(Color(0xFFFF0000)));
      expect(fromCssColor('rgba(110%,0%,0%)'), equals(Color(0xFFFF0000)));
    });

    test('should throw format exception on incorrect rgb/rgba values', () {
      expect(() => fromCssColor('rgba(0%,0,0)'), throwsFormatException);
      expect(() => fromCssColor('rgb(q,0%,0%)'), throwsFormatException);
      expect(() => fromCssColor('rgba(q,r,zcv)'), throwsFormatException);
      expect(() => fromCssColor('rgb(100,100)'), throwsFormatException);
      expect(() => fromCssColor('rgba(0%)'), throwsFormatException);
      expect(() => fromCssColor('rgb(0%,10%,5%,100%)'), throwsFormatException);
      expect(() => fromCssColor('rgba(0%,0,0,100%)'), throwsFormatException);
      expect(() => fromCssColor('rgb(q,0%,0%,q)'), throwsFormatException);
      expect(() => fromCssColor('rgb()'), throwsFormatException);
      expect(() => fromCssColor('rgba(((%^&*^(&*))'), throwsFormatException);
      expect(() => fromCssColor('rgb(-1000)'), throwsFormatException);
      expect(() => fromCssColor('rgba(1,10,5,)'), throwsFormatException);
    });

    test('should create from extended color keywords', () {
      expect(fromCssColor('darkgray'), equals(Color(0xFFA9A9A9)));
      expect(fromCssColor('bisque'), equals(Color(0xFFFFE4C4)));
      expect(fromCssColor('mediumslateblue'), equals(Color(0xFF7B68EE)));
      expect(fromCssColor('navy  '), equals(Color(0xFF000080)));
      expect(fromCssColor('violet'), equals(Color(0xFFEE82EE)));
    });

    test('should create from "transparent" color keyword', () {
      expect(fromCssColor('transparent'), equals(Color(0x00000000)));
    });

    test(
        'should throw format exception if the provided color format is unknown',
        () {
      expect(() => fromCssColor('strangecolor'), throwsFormatException);
      expect(() => fromCssColor('12'), throwsFormatException);
      expect(() => fromCssColor(''), throwsFormatException);
    });

    test('should create from correct hsl/hsla values', () {
      expect(fromCssColor('hsl(0,0%,0%)'), equals(Color(0xFF000000)));
      expect(fromCssColor('hsla(0,0%,0%,0)'), equals(Color(0x00000000)));
      expect(fromCssColor('hsl(0,100%,0%)'), equals(Color(0xFF000000)));
      expect(fromCssColor('hsl(0,100%,50%)'), equals(Color(0xFFFF0000)));
      expect(fromCssColor('hsl(360,100%,50%)'), equals(Color(0xFFFF0000)));
      expect(fromCssColor('hsl(720,100%,50%)'), equals(Color(0xFFFF0000)));
      expect(fromCssColor('hsl(120,100%,50%)'), equals(Color(0xFF00FF00)));
      expect(fromCssColor('hsl(240,100%,50%)'), equals(Color(0xFF0000FF)));
      expect(fromCssColor('hsl(-120,100%,50%)'), equals(Color(0xFF0000FF)));
      expect(
          fromCssColor('hsla(-120,100%,50%, .5)'), equals(Color(0x7F0000FF)));
      expect(fromCssColor('hsl(123,0%,100%)'), equals(Color(0xFFFFFFFF)));
      expect(fromCssColor('hsl(-120,100%,50%,0)'), equals(Color(0x000000FF)));
      expect(fromCssColor('hsl(-120,0%,50%)'), equals(Color(0xFF7F7F7F)));
      expect(fromCssColor('hsl(100,50%,10%)'), equals(Color(0xFF15260C)));
      expect(fromCssColor('hsl(100,54.99%,10.9%)'), equals(Color(0xFF162b0c)));
      expect(fromCssColor('hsl(343, 90%, 21%)'), equals(Color(0xFF650520)));
      expect(fromCssColor('hsla(100,100%,100%)'), equals(Color(0xFFFFFFFF)));
      expect(fromCssColor('hsl(0,110%,50%)'), equals(Color(0xFFFF0000)));
      expect(fromCssColor('hsl(0,-10%,50%)'), equals(Color(0xFF7F7F7F)));
      expect(fromCssColor('  hsl(0,0%,0%,1)'), equals(Color(0xFF000000)));
    });

    test('should throw format exception on incorrect hsl/hsla values', () {
      expect(() => fromCssColor('hsla(0%,0,0)'), throwsFormatException);
      expect(() => fromCssColor('hsl(q,0%,0%)'), throwsFormatException);
      expect(() => fromCssColor('hsla(q,r,zcv)'), throwsFormatException);
      expect(() => fromCssColor('hsl(100,100)'), throwsFormatException);
      expect(() => fromCssColor('hsla(0%)'), throwsFormatException);
      expect(() => fromCssColor('hsl(0%,10%,5%,100%)'), throwsFormatException);
      expect(() => fromCssColor('hsla(0%,0,0,100%)'), throwsFormatException);
      expect(() => fromCssColor('hsl(q,0%,0%,q)'), throwsFormatException);
      expect(() => fromCssColor('hsl()'), throwsFormatException);
      expect(() => fromCssColor('hsla(((%^&*^(&*))'), throwsFormatException);
      expect(() => fromCssColor('hsl(-1000)'), throwsFormatException);
      expect(() => fromCssColor('hsla(1,10,5,)'), throwsFormatException);
    });
  });

  group('isCssColor:', () {
    test('should return true for correct 3 and 6 character hex values', () {
      expect(isCssColor('#fbafba'), equals(true));
      expect(isCssColor('#f23b0c'), equals(true));
      expect(isCssColor('#fba'), equals(true));
      expect(isCssColor('  #fba    '), equals(true));
    });

    test('should return true for correct 4 and 8 character hex values', () {
      expect(isCssColor('#fbafbafa'), equals(true));
      expect(isCssColor('#f23b0c00'), equals(true));
      expect(isCssColor('#fbaa'), equals(true));
      expect(isCssColor('#fbaf'), equals(true));
      expect(isCssColor('  #fbac    '), equals(true));
    });

    test('should return false for incorrect hex values', () {
      expect(isCssColor('#fbafa'), equals(false));
      expect(isCssColor('#f'), equals(false));
      expect(isCssColor('#'), equals(false));
      expect(isCssColor('3ac57b'), equals(false));
      expect(isCssColor('#hba'), equals(false));
      expect(isCssColor('#1l4x5d'), equals(false));
      expect(isCssColor('#1l4x5dd'), equals(false));
      expect(isCssColor('#1b4a5d2x'), equals(false));
      expect(isCssColor('#1d4c5daab'), equals(false));
      expect(isCssColor('#1d4 c5d'), equals(false));
    });

    test('should return true for correct rgb/rgba values', () {
      expect(isCssColor('rgb(0,0,0)'), equals(true));
      expect(isCssColor('rgba(0%,0%,0%)'), equals(true));
      expect(isCssColor('rgb(255,255,255)'), equals(true));
      expect(isCssColor('rgba(100%,100%,100%)'), equals(true));
      expect(isCssColor('rgb(100,5,32)'), equals(true));
      expect(isCssColor('rgba(2.5,0.4,265.5)'), equals(true));
      expect(isCssColor('rgb(300,0,0)'), equals(true));
      expect(isCssColor('rgba(255,-10,0) '), equals(true));
      expect(isCssColor('rgb(110%,0%,0%)'), equals(true));
      expect(isCssColor('rgb(0,0,0,0)'), equals(true));
      expect(isCssColor('rgba(0%,0%,0%,0)'), equals(true));
      expect(isCssColor('  rgb(0,0,0,1)'), equals(true));
      expect(isCssColor('rgba(255,255,255,0)'), equals(true));
      expect(isCssColor('rgb(100%,100%,100%,1)'), equals(true));
      expect(isCssColor('rgba(100,5,32,0.5)'), equals(true));
      expect(isCssColor('rgb(2.5,0.4,265.5,0.2222)'), equals(true));
      expect(isCssColor('rgba(300,0,0,-1)'), equals(true));
      expect(isCssColor('rgb(255,-10,0,1000)'), equals(true));
      expect(isCssColor('rgba(110%,0%,0%)'), equals(true));
    });

    test('should return false for incorrect rgb/rgba values', () {
      expect(isCssColor('rgba(0%,0,0)'), equals(false));
      expect(isCssColor('rgb(q,0%,0%)'), equals(false));
      expect(isCssColor('rgba(q,r,zcv)'), equals(false));
      expect(isCssColor('rgb(100,100)'), equals(false));
      expect(isCssColor('rgba(0%)'), equals(false));
      expect(isCssColor('rgb(0%,10%,5%,100%)'), equals(false));
      expect(isCssColor('rgba(0%,0,0,100%)'), equals(false));
      expect(isCssColor('rgb(q,0%,0%,q)'), equals(false));
      expect(isCssColor('rgb()'), equals(false));
      expect(isCssColor('rgba(((%^&*^(&*))'), equals(false));
      expect(isCssColor('rgb(-1000)'), equals(false));
      expect(isCssColor('rgba(1,10,5,)'), equals(false));
    });

    test('should return true for extended color keywords', () {
      expect(isCssColor('darkgray'), equals(true));
      expect(isCssColor('bisque'), equals(true));
      expect(isCssColor('mediumslateblue'), equals(true));
      expect(isCssColor('navy  '), equals(true));
      expect(isCssColor('violet'), equals(true));
    });

    test('should return true from "transparent" color keyword', () {
      expect(isCssColor('transparent'), equals(true));
    });

    test('should return false if the provided color format is unknown', () {
      expect(isCssColor('strangecolor'), equals(false));
      expect(isCssColor('12'), equals(false));
      expect(isCssColor(''), equals(false));
    });

    test('should return true for correct hsl/hsla values', () {
      expect(isCssColor('hsl(0,0%,0%)'), equals(true));
      expect(isCssColor('hsla(0,0%,0%,0)'), equals(true));
      expect(isCssColor('hsl(0,100%,0%)'), equals(true));
      expect(isCssColor('hsl(0,100%,50%)'), equals(true));
      expect(isCssColor('hsl(360,100%,50%)'), equals(true));
      expect(isCssColor('hsl(720,100%,50%)'), equals(true));
      expect(isCssColor('hsl(120,100%,50%)'), equals(true));
      expect(isCssColor('hsl(240,100%,50%)'), equals(true));
      expect(isCssColor('hsl(-120,100%,50%)'), equals(true));
      expect(isCssColor('hsla(-120,100%,50%, .5)'), equals(true));
      expect(isCssColor('hsl(123,0%,100%)'), equals(true));
      expect(isCssColor('hsl(-120,100%,50%,0)'), equals(true));
      expect(isCssColor('hsl(-120,0%,50%)'), equals(true));
      expect(isCssColor('hsl(100,50%,10%)'), equals(true));
      expect(isCssColor('hsl(100,54.99%,10.9%)'), equals(true));
      expect(isCssColor('hsl(343, 90%, 21%)'), equals(true));
      expect(isCssColor('hsla(100,100%,100%)'), equals(true));
      expect(isCssColor('hsl(0,110%,50%)'), equals(true));
      expect(isCssColor('hsl(0,-10%,50%)'), equals(true));
      expect(isCssColor('  hsl(0,0%,0%,1)'), equals(true));
    });

    test('should return false for incorrect hsl/hsla values', () {
      expect(isCssColor('hsla(0%,0,0)'), equals(false));
      expect(isCssColor('hsl(q,0%,0%)'), equals(false));
      expect(isCssColor('hsla(q,r,zcv)'), equals(false));
      expect(isCssColor('hsl(100,100)'), equals(false));
      expect(isCssColor('hsla(0%)'), equals(false));
      expect(isCssColor('hsl(0%,10%,5%,100%)'), equals(false));
      expect(isCssColor('hsla(0%,0,0,100%)'), equals(false));
      expect(isCssColor('hsl(q,0%,0%,q)'), equals(false));
      expect(isCssColor('hsl()'), equals(false));
      expect(isCssColor('hsla(((%^&*^(&*))'), equals(false));
      expect(isCssColor('hsl(-1000)'), equals(false));
      expect(isCssColor('hsla(1,10,5,)'), equals(false));
    });
  });
}
