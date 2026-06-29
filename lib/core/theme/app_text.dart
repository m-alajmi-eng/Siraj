import 'package:flutter/material.dart';
import 'design_tokens.dart';

// ═══════════════════════════════════════════════════════
// AppText — نظام النصوص المركزي
// كل نص في التطبيق يستخدم نمطاً من هنا. لا TextStyle يدوي.
// الخط NotoSansArabic يدعم كل اللغات تلقائياً.
// ═══════════════════════════════════════════════════════
class AppText {
  AppText._();

  static const String _f = SirajFonts.ui;

  // ─── العناوين الكبيرة ───
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.s4xl,
    fontWeight: FontWeight.w300,
    height:     SirajLineHeights.tight,
    color:      SirajWhite.w92,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.s3xl,
    fontWeight: FontWeight.w300,
    height:     SirajLineHeights.tight,
    color:      SirajWhite.w92,
  );

  static const TextStyle title = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.s2xl,
    fontWeight: FontWeight.w300,
    height:     SirajLineHeights.snug,
    color:      SirajWhite.w92,
  );

  // ─── نصوص العناوين الفرعية ───
  static const TextStyle headline = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.sXl,
    fontWeight: FontWeight.w500,
    height:     SirajLineHeights.snug,
    color:      SirajWhite.w92,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.sLg,
    fontWeight: FontWeight.w400,
    height:     SirajLineHeights.normal,
    color:      SirajWhite.w88,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.sMd,
    fontWeight: FontWeight.w400,
    height:     SirajLineHeights.normal,
    color:      SirajWhite.w80,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.sBase,
    fontWeight: FontWeight.w400,
    height:     SirajLineHeights.snug,
    color:      SirajWhite.w70,
  );

  // ─── تسميات وثانوي ───
  static const TextStyle caption = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.sSm,
    fontWeight: FontWeight.w400,
    height:     SirajLineHeights.snug,
    color:      SirajWhite.w40,
  );

  static const TextStyle label = TextStyle(
    fontFamily:    _f,
    fontSize:      SirajSizes.sXs,
    fontWeight:    FontWeight.w500,
    letterSpacing: 3.0,
    color:         SirajWhite.w25,
  );

  // ─── القرآن الكريم ───
  static const TextStyle quran = TextStyle(
    fontFamily: SirajFonts.quran,
    fontSize:   SirajSizes.s2xl,
    height:     SirajLineHeights.quran,
    color:      SirajWhite.w92,
  );

  static const TextStyle quranLarge = TextStyle(
    fontFamily: SirajFonts.quran,
    fontSize:   SirajSizes.s3xl,
    height:     SirajLineHeights.quran,
    color:      SirajWhite.w92,
  );

  // ─── أرقام (لاتيني دائماً) ───
  static const TextStyle numeral = TextStyle(
    fontFamily: SirajFonts.latin,
    fontSize:   SirajSizes.sLg,
    fontWeight: FontWeight.w500,
    color:      SirajWhite.w75,
  );

  static const TextStyle prayerNameBig = TextStyle(
    fontFamily: _f,
    fontSize:   SirajSizes.s4xl,
    fontWeight: FontWeight.w600,
    height:     SirajLineHeights.tight,
    color:      SirajWhite.w92,
  );
}
