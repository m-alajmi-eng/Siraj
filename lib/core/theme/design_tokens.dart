import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════
// SIRAJ Design System — v1.0
// Spiritual Minimalism — every pixel has purpose.
// ═══════════════════════════════════════════════════════

// ─── Gold Tokens ────────────────────────────────────────
class SirajGold {
  static const pure   = Color(0xFFC9A96E);
  static const light  = Color(0xFFE8C78D);
  static const dark   = Color(0xFFA8854A);

  static const faint  = Color(0x0FC9A96E);
  static const subtle = Color(0x1EC9A96E);
  static const soft   = Color(0x3DC9A96E);
  static const muted  = Color(0x73C9A96E);
  static const mid    = Color(0xA6C9A96E);
  static const strong = Color(0xD1C9A96E);
  static const vivid  = Color(0xF5C9A96E);
}

// ─── Canvas Backgrounds ─────────────────────────────────
class SirajCanvas {
  static const deep   = Color(0xFF000204);
  static const base   = Color(0xFF010308);
  static const raised = Color(0xFF020510);
}

// ─── White Scale ────────────────────────────────────────
class SirajWhite {
  static const w4  = Color(0x0AFFFFFF);
  static const w7  = Color(0x12FFFFFF);
  static const w10 = Color(0x1AFFFFFF);
  static const w14 = Color(0x24FFFFFF);
  static const w18 = Color(0x2EFFFFFF);
  static const w20 = Color(0x33FFFFFF);
  static const w25 = Color(0x40FFFFFF);
  static const w30 = Color(0x4DFFFFFF);
  static const w40 = Color(0x66FFFFFF);
  static const w50 = Color(0x80FFFFFF);
  static const w60 = Color(0x99FFFFFF);
  static const w70 = Color(0xB3FFFFFF);
  static const w75 = Color(0xBFFFFFFF);
  static const w80 = Color(0xCCFFFFFF);
  static const w85 = Color(0xD9FFFFFF);
  static const w88 = Color(0xE0FFFFFF);
  static const w92 = Color(0xEBFFFFFF);
  static const w96 = Color(0xF5FFFFFF);
}

// ─── Semantic Colors ────────────────────────────────────
class SirajSemantic {
  static const infoBg      = Color(0x1C6EB4D0);
  static const infoBorder  = Color(0x386EB4D0);
  static const infoText    = Color(0xD96EB4D0);

  static const successBg     = Color(0x1C50B478);
  static const successBorder = Color(0x3850B478);
  static const successText   = Color(0xD950B478);

  static const warningBg     = Color(0x1CDC9032);
  static const warningBorder = Color(0x38DC9032);
  static const warningText   = Color(0xD9DC9032);

  static const errorBg     = Color(0x1CDC463C);
  static const errorBorder = Color(0x38DC463C);
  static const errorText   = Color(0xD9EB6455);
}

// ─── Typography ─────────────────────────────────────────
class SirajFonts {
  static const display = 'PlayfairDisplay';
  static const body    = 'Inter';
  static const quran   = 'AmiriQuran';
  static const arabic  = 'NotoNaskhArabic';
  static const mono    = 'DMMono';
}

class SirajSizes {
  static const s2xs = 9.0;
  static const sXs  = 10.0;
  static const sSm  = 11.0;
  static const sBase = 13.0;
  static const sMd  = 15.0;
  static const sLg  = 17.0;
  static const sXl  = 21.0;
  static const s2xl = 26.0;
  static const s3xl = 32.0;
  static const s4xl = 40.0;
  static const s5xl = 48.0;
}

class SirajLineHeights {
  static const tight   = 1.2;
  static const snug    = 1.4;
  static const normal  = 1.65;
  static const relaxed = 1.80;
  static const loose   = 2.0;
  static const quran   = 2.3;
}

// ─── Spacing ────────────────────────────────────────────
class SirajSpacing {
  static const s1  = 4.0;
  static const s2  = 8.0;
  static const s3  = 12.0;
  static const s4  = 16.0;
  static const s5  = 20.0;
  static const s6  = 24.0;
  static const s8  = 32.0;
  static const s10 = 40.0;
  static const s12 = 48.0;
  static const s16 = 64.0;
}

// ─── Radius ─────────────────────────────────────────────
class SirajRadius {
  static const sm  = 8.0;
  static const md  = 12.0;
  static const lg  = 16.0;
  static const xl  = 20.0;
  static const full = 999.0;
}

// ─── Motion ─────────────────────────────────────────────
class SirajMotion {
  static const micro  = Duration(milliseconds: 150);
  static const fast   = Duration(milliseconds: 250);
  static const normal = Duration(milliseconds: 350);
  static const slow   = Duration(milliseconds: 500);
}

// ─── Radius (updated) ───────────────────────────────────
class SirajRadiusFull {
  static const xs   = 6.0;
  static const sm   = 10.0;
  static const md   = 14.0;
  static const lg   = 18.0;
  static const xl   = 22.0;
  static const x2l  = 26.0;
  static const x3l  = 32.0;
  static const pill = 999.0;
}

// ─── Elevation ──────────────────────────────────────────
class SirajElevation {
  static const e1 = [BoxShadow(color: Color(0x1F000000), blurRadius: 8,  offset: Offset(0, 2))];
  static const e2 = [BoxShadow(color: Color(0x2E000000), blurRadius: 18, offset: Offset(0, 4)), BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 1))];
  static const e3 = [BoxShadow(color: Color(0x3D000000), blurRadius: 32, offset: Offset(0, 8)), BoxShadow(color: Color(0x1F000000), blurRadius: 8, offset: Offset(0, 2))];
}

// ─── Sky Phases ─────────────────────────────────────────
enum SkyPhase { fajr, sunrise, morning, dhuhr, asr, maghrib, isha }

class SirajSky {
  static SkyPhase fromHour(int h) {
    if (h >= 3  && h < 5)  return SkyPhase.fajr;
    if (h >= 5  && h < 7)  return SkyPhase.sunrise;
    if (h >= 7  && h < 12) return SkyPhase.morning;
    if (h >= 12 && h < 15) return SkyPhase.dhuhr;
    if (h >= 15 && h < 18) return SkyPhase.asr;
    if (h >= 18 && h < 20) return SkyPhase.maghrib;
    return SkyPhase.isha;
  }

  static String nameAr(SkyPhase p) {
    switch (p) {
      case SkyPhase.fajr:    return 'الفجر';
      case SkyPhase.sunrise: return 'الشروق';
      case SkyPhase.morning: return 'الصباح';
      case SkyPhase.dhuhr:   return 'الظهيرة';
      case SkyPhase.asr:     return 'العصر';
      case SkyPhase.maghrib: return 'المغرب';
      case SkyPhase.isha:    return 'العشاء';
    }
  }

  static List<Color> gradientColors(SkyPhase p) {
    switch (p) {
      case SkyPhase.fajr:
        return [const Color(0xFF020409), const Color(0xFF06081A), const Color(0xFF160828), const Color(0xFF3E0E24), const Color(0xFF741E20), const Color(0xFFA23A2C)];
      case SkyPhase.sunrise:
        return [const Color(0xFF12185A), const Color(0xFF223C7E), const Color(0xFF9A5820), const Color(0xFFDEAD28)];
      case SkyPhase.morning:
        return [const Color(0xFF163264), const Color(0xFF1F54A0), const Color(0xFF4592CA), const Color(0xFF78BEDE)];
      case SkyPhase.dhuhr:
        return [const Color(0xFF184484), const Color(0xFF2664AE), const Color(0xFF4C9ACC), const Color(0xFF98CAEC)];
      case SkyPhase.asr:
        return [const Color(0xFF163266), const Color(0xFF24467C), const Color(0xFF5474B4), const Color(0xFFB49A60)];
      case SkyPhase.maghrib:
        return [const Color(0xFF030610), const Color(0xFF0B0820), const Color(0xFF24102C), const Color(0xFF661820), const Color(0xFFAE3C0C), const Color(0xFFD06610), const Color(0xFFE68C18)];
      case SkyPhase.isha:
        return [const Color(0xFF01030A), const Color(0xFF03060E), const Color(0xFF060918), const Color(0xFF090D22), const Color(0xFF0D1128)];
    }
  }
}

// ─── Layout ─────────────────────────────────────────────
class SirajLayout {
  static const pagePadding = 20.0;
  static const colGutter   = 9.0;
  static const sectionGap  = 32.0;
}
