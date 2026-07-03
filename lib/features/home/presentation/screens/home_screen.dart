import 'package:flutter/material.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../quran/presentation/providers/quran_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_label.dart';
import '../../../../core/storage/cache_service.dart';
import '../../../prayer/presentation/providers/prayer_provider.dart';
import '../../../calendar/presentation/providers/calendar_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greet(AppLocalizations t, int h) {
    if (h < 5)  return t.home_greetingNight;
    if (h < 7)  return t.home_greetingFajr;
    if (h < 12) return t.home_greetingMorning;
    if (h < 15) return t.home_greetingNoon;
    if (h < 18) return t.home_greetingAsr;
    if (h < 20) return t.home_greetingEvening;
    return t.home_greetingLateNight;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t           = AppLocalizations.of(context);
    final prayerAsync = ref.watch(prayerTimesProvider);
    final hijriDate   = ref.watch(hijriTodayProvider);
    final readingPos  = CacheService.getReadingPosition();
    final lastSurahId = readingPos?['surahId'];
    final lastAyahNum = readingPos?['ayahNumber'];
    final now         = DateTime.now();
    final h           = now.hour;
    final skyColors   = SirajSky.gradientColors(SirajSky.fromHour(h));
    final hijriStr    = '${hijriDate.day} / ${hijriDate.month} / ${hijriDate.year}';

    return Scaffold(
      backgroundColor: SirajCanvas.base,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin:  Alignment.topCenter,
                  end:    Alignment.bottomCenter,
                  colors: skyColors,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: SirajLayout.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: SirajSpacing.s2),
                  const _Header(),
                  const SizedBox(height: SirajSpacing.s5),
                  _Greeting(greeting: _greet(t, h), hijriDate: hijriStr),
                  const SizedBox(height: SirajSpacing.s5),
                  prayerAsync.when(
                    loading: () => const _Skeleton(height: 180),
                    error:   (e, _) => const SizedBox(),
                    data:    (times) => _NextPrayerCard(times: times),
                  ),
                  const SizedBox(height: SirajSpacing.s3),
                  if (lastSurahId != null) ...[
                    _ContinueReading(
                      surahId:    lastSurahId,
                      ayahNumber: lastAyahNum ?? 1,
                      onTap: () => context.push('/quran/surah/$lastSurahId'),
                    ),
                    const SizedBox(height: SirajSpacing.s3),
                  ],
                  const _DailyAyah(),
                  const SizedBox(height: SirajSpacing.s5),
                  SectionLabel(label: t.home_quickAccess),
                  const SizedBox(height: SirajSpacing.s3),
                  const _QuickActions(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: SirajSpacing.s4, left: SirajSpacing.s5, right: SirajSpacing.s5,
            child: _FloatingSearch(onTap: () => context.push('/more/search')),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color:  SirajWhite.w7,
                shape:  BoxShape.circle,
                border: Border.all(color: SirajWhite.w10),
              ),
              child: const Icon(Icons.notifications_none_rounded,
                color: SirajWhite.w60, size: 16),
            ),
            PositionedDirectional(
              top: 9, start: 9,
              child: Container(
                width: 6, height: 6,
                decoration: const BoxDecoration(
                  color: SirajGold.pure,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: SirajGold.muted, blurRadius: 5)],
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(t.app_brand_name, style: AppText.headline.copyWith(
                  fontWeight: FontWeight.w300, letterSpacing: 6.0,
                  fontSize: SirajSizes.sXl)),
                Text(t.app_tagline, style: AppText.label.copyWith(
                  letterSpacing: 1.6)),
                const SizedBox(height: 2),
                Text('سـراج', style: TextStyle(
                  fontFamily: SirajFonts.brand,
                  fontWeight: FontWeight.w700,
                  fontSize: SirajSizes.sXl,
                  letterSpacing: 0.5,
                  color: AppText.headline.color,
                )),
          ],
        ),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  final String greeting;
  final String hijriDate;
  const _Greeting({required this.greeting, required this.hijriDate});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(greeting, style: AppText.bodySmall.copyWith(color: SirajWhite.w40)),
        const SizedBox(height: 2),
        Text(t.home_welcome, style: AppText.displayMedium.copyWith(
          fontWeight: FontWeight.w500, fontStyle: FontStyle.italic,
          fontSize: 29)),
        const SizedBox(height: SirajSpacing.s3),
        Row(
          children: [
            Container(
              width: 3, height: 3,
              decoration: const BoxDecoration(
                color: SirajGold.muted, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(hijriDate, style: AppText.caption),
          ],
        ),
      ],
    );
  }
}

class _NextPrayerCard extends StatelessWidget {
  final dynamic times;
  const _NextPrayerCard({required this.times});

  String _prayerName(AppLocalizations t, dynamic times) {
    final now = DateTime.now();
    if (now.isBefore(times.fajr))    return t.prayer_fajr;
    if (now.isBefore(times.dhuhr))   return t.prayer_dhuhr;
    if (now.isBefore(times.asr))     return t.prayer_asr;
    if (now.isBefore(times.maghrib)) return t.prayer_maghrib;
    if (now.isBefore(times.isha))    return t.prayer_isha;
    return t.prayer_fajr;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tm = times.nextPrayerTime;
    final timeStr = tm.hour.toString().padLeft(2, '0') +
        ':' + tm.minute.toString().padLeft(2, '0');

    return GlassCard(
      radius: SirajRadiusFull.x2l,
      alpha: 0.09,
      padding: const EdgeInsets.all(SirajSpacing.s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: t.home_nextPrayer),
          const SizedBox(height: SirajSpacing.s4),
          Text(_prayerName(t, times), style: AppText.prayerNameBig),
          const SizedBox(height: SirajSpacing.s1),
          Text(timeStr, style: AppText.numeral),
          const SizedBox(height: SirajSpacing.s4),
          Container(
            height: 1.5,
            decoration: BoxDecoration(
              color: SirajWhite.w7,
              borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
            ),
          ),
          const SizedBox(height: SirajSpacing.s4),
          GestureDetector(
            onTap: () => context.push('/more/qibla'),
            child: Row(
              children: [
                const Icon(Icons.explore_outlined, color: SirajGold.strong, size: 12),
                const SizedBox(width: SirajSpacing.s1),
                Text(t.home_qiblaDirection, style: AppText.caption.copyWith(
                  color: SirajGold.strong, fontSize: SirajSizes.sSm)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueReading extends StatelessWidget {
  final int surahId;
  final int ayahNumber;
  final VoidCallback onTap;
  const _ContinueReading({
    required this.surahId,
    required this.ayahNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        radius: SirajRadiusFull.xl,
        padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s5, vertical: SirajSpacing.s4),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: SirajGold.faint,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: SirajGold.subtle),
              ),
              child: const Icon(Icons.menu_book_rounded,
                color: SirajGold.strong, size: 16),
            ),
            const SizedBox(width: SirajSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.home_continueReading, style: AppText.label.copyWith(
                    fontSize: SirajSizes.s2xs, letterSpacing: 2.8)),
                  const SizedBox(height: 3),
                  Text(t.home_surah(surahId), style: AppText.body),
                  const SizedBox(height: 2),
                  Text(t.home_ayah(ayahNumber), style: AppText.caption),
                ],          ),
            ),
            const Icon(Icons.chevron_left, color: SirajWhite.w40, size: 18),
          ],
        ),
      ),
    );
  }
}

class _DailyAyah extends ConsumerWidget {
  const _DailyAyah();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t    = AppLocalizations.of(context);
    final lang = ref.watch(localeProvider).languageCode;

    // (عربي، مرجع نصّي، سورة، آية، fallback إنجليزي)
    const ayahs = [
      ('أَلَا بِذِكْرِ اللَّهِ تطمَئِنُّ القُلُوب',
       'الرعد ١٣:٢٨', 13, 28,
       'Verily, in the remembrance of Allah do hearts find rest.'),
      ('إِنَّ مَعَ العسْرِ يُسْرًا',
       'الشرح ٩٤:٦', 94, 6,
       'Indeed, with hardship comes ease.'),
      ('وَمن يَتَّقِ اللَّهَ يَجْعل لَّهُ مَخرَجًا',
       'الطلاق ٦٥:٢', 65, 2,
       'And whoever fears Allah, He will make for him a way out.'),
    ];
    final ayah = ayahs[DateTime.now().day % ayahs.length];

    // العربية: لا ترجمة. غيرها: نجلب من alquran.cloud
    final transAsync = lang == 'ar'
        ? null
        : ref.watch(dailyAyahTranslationProvider('${ayah.$3}:${ayah.$4}:$lang'));

    return GlassCard(
      radius: SirajRadiusFull.xl,
      padding: const EdgeInsets.all(SirajSpacing.s5),
      child: Column(
        children: [
          SectionLabel(label: t.home_dailyAyah),
          const SizedBox(height: SirajSpacing.s4),
          Text(ayah.$1, textAlign: TextAlign.center,
 textDirection: TextDirection.rtl, style: AppText.quran),
          if (lang != 'ar') ...[
            const SizedBox(height: SirajSpacing.s3),
            transAsync!.when(
              data: (text) => text == null
                  ? const SizedBox.shrink()
                  : Text('"$text"', textAlign: TextAlign.center,
                      style: AppText.bodySmall.copyWith(
                        fontStyle: FontStyle.italic,
                        height: SirajLineHeights.normal)),
              loading: () => const SizedBox(
                height: 16, width: 16,
                child: Center(
                  child: SizedBox(height: 12, width: 12,
                    child: CircularProgressIndicator(strokeWidth: 1.5)))),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
          const SizedBox(height: SirajSpacing.s4),
          Row(children: [
 Expanded(child: Container(height: 0.5, color: SirajWhite.w7)),
 Padding(
   padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s3),
   child: Text(ayah.$2, style: AppText.label.copyWith(
     fontSize: SirajSizes.sXs, letterSpacing: 2.2)),
 ),
 Expanded(child: Container(height: 0.5, color: SirajWhite.w7)),
          ]),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final actions = [
      (Icons.menu_book_rounded,    t.nav_quran,           '/quran',                 false),
      (Icons.self_improvement,     t.nav_athkar,          '/athkar',                false),
      (Icons.local_library_outlined, t.nav_library,       '/library',               false),
      (Icons.explore_outlined,     t.home_qiblaDirection, '/more/qibla',            true),
      (Icons.radio,                t.home_radio,          '/more/radio',            true),
      (Icons.calendar_month,       t.home_calendar,       '/more/calendar',         true),
      (Icons.auto_stories,         t.home_stories,        '/more/stories',          true),
      (Icons.child_care,           t.home_children,       '/more/children_stories', true),
    (Icons.mosque_outlined,  t.gateway_entry_title,       '/gateway', true),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics:    const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:   4,
        crossAxisSpacing: SirajLayout.colGutter,
        mainAxisSpacing:  SirajLayout.colGutter,
        childAspectRatio: 0.85,
      ),
      itemCount: actions.length,
      itemBuilder: (_, i) {
        final (icon, label, route, isPush) = actions[i];
        return GestureDetector(
          onTap: () => isPush ? context.push(route) : context.go(route),
          child: GlassCard(
            radius: SirajRadiusFull.lg,
            padding: const EdgeInsets.symmetric(vertical: SirajSpacing.s4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: SirajWhite.w7,
                    borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                    border: Border.all(color: SirajWhite.w7),
                  ),
                  child: Icon(icon, color: SirajWhite.w75, size: 17),
                ),
                const SizedBox(height: SirajSpacing.s2),
                Text(label, textAlign: TextAlign.center,
                  style: AppText.caption.copyWith(fontSize: SirajSizes.sXs)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Skeleton extends StatelessWidget {
  final double height;
  const _Skeleton({required this.height});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: SirajRadiusFull.x2l, alpha: 0.05,
      child: SizedBox(height: height, width: double.infinity),
    );
  }
}

class _FloatingSearch extends StatelessWidget {
  final VoidCallback onTap;
  const _FloatingSearch({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s4, vertical: SirajSpacing.s3),
        decoration: BoxDecoration(
          color: const Color(0xBD08090A),
          borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
          border: Border.all(color: SirajWhite.w10),
          boxShadow: SirajElevation.e3,
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: SirajWhite.w30, size: 14),
            const SizedBox(width: SirajSpacing.s3),
            Expanded(child: Text(t.home_searchHint, style: AppText.bodySmall.copyWith(
              color: SirajWhite.w20))),
          ],
        ),
      ),
    );
  }
}
