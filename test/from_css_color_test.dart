import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:from_css_color/from_css_color.dart';

void main() {
  test('Should create from correct 3 and 6 character hex values', () {
    expect(fromCSSColor('#fbafba'), equals(Color(0xFFFBAFBA)));
    expect(fromCSSColor('#f23b0c'), equals(Color(0xFFF23B0C)));
    expect(fromCSSColor('#fba'), equals(Color(0xFFFFBBAA)));
    expect(fromCSSColor('#fba'), equals(Color(0xFFFFBBAA)));
    expect(fromCSSColor('  #fba    '), equals(Color(0xFFFFBBAA)));
  });

  test('Should throw format exception on incorrect hex values', () {
    expect(() => fromCSSColor('#fbafa'), throwsFormatException);
    expect(() => fromCSSColor('#f'), throwsFormatException);
    expect(() => fromCSSColor('#'), throwsFormatException);
    expect(() => fromCSSColor('3ac57b'), throwsFormatException);
    expect(() => fromCSSColor('#hba'), throwsFormatException);
    expect(() => fromCSSColor('#1l4x5d'), throwsFormatException);
  });

  test('Should create from correct rgb/rgba values', () {
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

  test('Should throw format exception on incorrect rgb/rgba values', () {
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

  test('Should create from extended color keywords', () {
    expect(fromCSSColor('darkgray'), equals(Color(0xFFA9A9A9)));
    expect(fromCSSColor('bisque'), equals(Color(0xFFFFE4C4)));
    expect(fromCSSColor('mediumslateblue'), equals(Color(0xFF7B68EE)));
    expect(fromCSSColor('navy  '), equals(Color(0xFF000080)));
    expect(fromCSSColor('violet'), equals(Color(0xFFEE82EE)));
  });

  test('Should throw format exception if the provided color format is unknown',
      () {
    expect(() => fromCSSColor('strangecolor'), throwsFormatException);
    expect(() => fromCSSColor('12'), throwsFormatException);
    expect(() => fromCSSColor(''), throwsFormatException);
  });

  test(
      'Should throw format exception if support for the provided color format is not implemented',
      () {
    expect(() => fromCSSColor('hsl(123,100%,50%)'), throwsUnimplementedError);
  });
}
