import 'dart:async';
import 'dart:math' as math;
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
import '../../../quran/presentation/providers/reading_context_provider.dart';
import '../../../prayer/presentation/providers/prayer_provider.dart';
import '../../../calendar/presentation/providers/calendar_provider.dart';
import '../../../../core/mode/app_mode.dart';
import '../../../../core/mode/app_mode_provider.dart';
import '../../../../core/mode/feature_flags.dart';
import '../../../../core/mode/enabled_sections_provider.dart';

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
    final lastContextAsync = ref.watch(continueReadingContextProvider);
    final now         = DateTime.now();
    final h           = now.hour;
    final skyPhase    = SirajSky.fromHour(h);
    final skyColors   = SirajSky.gradientColors(skyPhase);
    final hijriStr    = '${hijriDate.day} / ${hijriDate.month} / ${hijriDate.year}';
    // النجوم تظهر فقط في سماء الفجر/العشاء (الأكثر عتمة)، أسوة بمرجع
    // التصميم الذي يربط كثافة النجوم بمرحلة السماء الحالية.
    final showStars   = skyPhase == SkyPhase.fajr || skyPhase == SkyPhase.isha;

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
          if (showStars) const Positioned.fill(child: _StarField()),
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
                  if (lastContextAsync.value != null) ...[
                    _buildContinueReadingCard(context, t, lastContextAsync.value!),
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
        ],
      ),
    );
  }
}

/// أيقونة تبديل الوضع (خفيف/كامل) - ضغطة واحدة بسيطة، بلا نص أو
/// قائمة (كما في Kindle: التخصيص التفصيلي منفصل في الإعدادات، هنا
/// فقط تبديل سريع وفوري).
/// أيقونة بحث بسيطة في الرأس العلوي - بديل عن الزر العائم السابق
/// الذي بدا غير متناسق. نفس التصميم البصري لـ_ModeToggleIcon.
class _SearchIcon extends StatelessWidget {
  const _SearchIcon();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: t.more_search,
      child: GestureDetector(
        onTap: () => context.push('/more/search'),
        child: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: SirajWhite.w7,
            shape: BoxShape.circle,
            border: Border.all(color: SirajWhite.w10),
          ),
          child: const Icon(Icons.search, color: SirajGold.strong, size: 18),
        ),
      ),
    );
  }
}

class _ModeToggleIcon extends ConsumerWidget {
  const _ModeToggleIcon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final mode = ref.watch(appModeProvider);
    final isLite = mode == AppMode.lite;

    return Semantics(
      button: true,
      label: t.settings_appMode,
      child: GestureDetector(
        onTap: () => ref.read(appModeProvider.notifier).toggle(),
        child: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: SirajWhite.w7,
            shape: BoxShape.circle,
            border: Border.all(color: SirajWhite.w10),
          ),
          child: Icon(
            isLite ? Icons.bolt_outlined : Icons.apps_rounded,
            color: SirajGold.strong,
            size: 18,
          ),
        ),
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
        Row(
          children: [
            const _ModeToggleIcon(),
            const SizedBox(width: SirajSpacing.s2),
            const _SearchIcon(),
            const SizedBox(width: SirajSpacing.s2),
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

class _NextPrayerCard extends StatefulWidget {
  final dynamic times;
  const _NextPrayerCard({required this.times});

  @override
  State<_NextPrayerCard> createState() => _NextPrayerCardState();
}

class _NextPrayerCardState extends State<_NextPrayerCard>
    with SingleTickerProviderStateMixin {
  Timer? _tickTimer;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    // عدّاد تنازلي حي: نعيد بناء هذا الودجت فقط (لا الشاشة كاملة) كل ثانية
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String _prayerName(AppLocalizations t, dynamic times) {
    final now = DateTime.now();
    if (now.isBefore(times.fajr))    return t.prayer_fajr;
    if (now.isBefore(times.dhuhr))   return t.prayer_dhuhr;
    if (now.isBefore(times.asr))     return t.prayer_asr;
    if (now.isBefore(times.maghrib)) return t.prayer_maghrib;
    if (now.isBefore(times.isha))    return t.prayer_isha;
    return t.prayer_fajr;
  }

  /// يحسب بداية ونهاية الفترة الحالية بين صلاتين لأجل شريط التقدّم.
  (DateTime start, DateTime end) _prayerWindow(dynamic times) {
    final ordered = <DateTime>[
      times.fajr, times.dhuhr, times.asr, times.maghrib, times.isha,
    ];
    final now = DateTime.now();
    for (var i = 0; i < ordered.length; i++) {
      if (now.isBefore(ordered[i])) {
        final start = i == 0
            ? times.isha.subtract(const Duration(days: 1)) as DateTime
            : ordered[i - 1];
        return (start, ordered[i]);
      }
    }
    return (times.isha, times.fajr.add(const Duration(days: 1)) as DateTime);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final times = widget.times;
    final tm = times.nextPrayerTime;
    final timeStr = tm.hour.toString().padLeft(2, '0') +
        ':' + tm.minute.toString().padLeft(2, '0');

    final remaining = times.timeUntilNextPrayer as Duration;
    final hh = remaining.inHours.clamp(0, 99);
    final mm = remaining.inMinutes.remainder(60);
    final ss = remaining.inSeconds.remainder(60);
    String pad2(int n) => n.toString().padLeft(2, '0');

    final (start, end) = _prayerWindow(times);
    final total = end.difference(start).inSeconds;
    final elapsed = DateTime.now().difference(start).inSeconds;
    final progress = total > 0
        ? (elapsed / total).clamp(0.0, 1.0)
        : 0.0;
    final progressFlex = (progress * 1000).round().clamp(1, 999);

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
          // عدّاد تنازلي حي (ساعة:دقيقة:ثانية)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _CountdownUnit(value: pad2(hh), unit: t.time_hr),
              _CountdownColon(),
              _CountdownUnit(value: pad2(mm), unit: t.time_min),
              _CountdownColon(),
              _CountdownUnit(value: pad2(ss), unit: t.time_sec),
            ],
          ),
          const SizedBox(height: SirajSpacing.s4),
          // شريط تقدّم متحرك بين الصلاة الحالية والقادمة، بنقطة نابضة
          // عند حد التقدّم - يتكيّف مع RTL/LTR تلقائياً عبر Row (flex)
          SizedBox(
            height: 10,
            child: Row(
              children: [
                Expanded(
                  flex: progressFlex,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
                      gradient: LinearGradient(
                        colors: [SirajGold.soft, SirajGold.strong],
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, _) {
                    final scale = 1.0 + (_pulseController.value * 0.35);
                    return Container(
                      width: 8 * scale,
                      height: 8 * scale,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SirajGold.pure,
                        boxShadow: [
                          BoxShadow(
                            color: SirajGold.muted,
                            blurRadius: 6 * scale,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  flex: (1000 - progressFlex).clamp(1, 999),
                  child: Container(
                    height: 1.5,
                    decoration: BoxDecoration(
                      color: SirajWhite.w7,
                      borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
                    ),
                  ),
                ),
              ],
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

class _CountdownUnit extends StatelessWidget {
  final String value;
  final String unit;
  const _CountdownUnit({required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppText.numeral.copyWith(fontSize: SirajSizes.sXl)),
        const SizedBox(height: 2),
        Text(unit, style: AppText.label.copyWith(
          fontSize: SirajSizes.s2xs, letterSpacing: 1.8, color: SirajWhite.w20)),
      ],
    );
  }
}

class _CountdownColon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(':', style: AppText.numeral.copyWith(
        fontSize: SirajSizes.sXl, color: SirajWhite.w18)),
    );
  }
}

/// يبني بطاقة "متابعة القراءة". بعد إزالة المصحف المطبوع (PHASE K)
/// كل سياق (بما فيه القديم بالصفحات) يصل هنا مطبَّعاً كسورة/آية عبر
/// continueReadingContextProvider — سياق واحد فقط للتعامل معه.
Widget _buildContinueReadingCard(
  BuildContext context,
  AppLocalizations t,
  Map<String, dynamic> ctx,
) {
  final surahId = ctx['surahId'] as int?;
  final ayahNumber = ctx['ayahNumber'] as int? ?? 1;
  if (surahId == null) return const SizedBox();
  return _ContinueReading(
    primaryLine: t.home_surah(surahId),
    secondaryLine: t.home_ayah(ayahNumber),
    onTap: () => context.push('/quran/surah/$surahId'),
  );
}

class _ContinueReading extends StatelessWidget {
  final String primaryLine;
  final String secondaryLine;
  final VoidCallback onTap;
  const _ContinueReading({
    required this.primaryLine,
    required this.secondaryLine,
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
                  Text(primaryLine, style: AppText.body),
                  const SizedBox(height: 2),
                  Text(secondaryLine, style: AppText.caption),
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
              error: (_, _) => const SizedBox.shrink(),
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

class _QuickActions extends ConsumerWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final mode = ref.watch(appModeProvider);
    final enabled = ref.watch(enabledSectionsProvider);
    final flags = FeatureFlags(mode, enabledSections: enabled);
    // القرآن/الأذكار/المكتبة/الحديث حُذفت من هنا (PHASE I، ADR-007) — صارت
    // تبويبات في الشريط السفلي (PHASE H1)، فبقاؤها هنا كان تكراراً محضاً
    // (مدخلان لنفس الوجهة). الشبكة الآن تعرض فقط ما ليس تبويباً.
    final allActions = [
      (Icons.explore_outlined,     t.home_qiblaDirection, '/more/qibla',            true,  flags.showQibla),
      (Icons.radio,                t.home_radio,          '/more/radio',            true,  flags.showRadio),
      (Icons.calendar_month,       t.home_calendar,       '/more/calendar',         true,  flags.showCalendar),
      (Icons.auto_stories,         t.home_stories,        '/more/stories',          true,  flags.showStories),
      (Icons.child_care,           t.home_children,       '/more/children_stories', true,  flags.showChildrenStories),
      (Icons.mosque_outlined,  t.gateway_entry_title,     '/gateway', true, flags.showGateway),
    ];
    final actions = allActions.where((a) => a.$5).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        const crossAxisCount = 4;
        final spacing = SirajLayout.colGutter;
        final itemWidth =
            (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: actions.map((action) {
            final (icon, label, route, isPush, _) = action;
            return SizedBox(
              width: itemWidth,
              height: itemWidth / 0.85,
              child: GestureDetector(
                onTap: () =>
                    isPush ? context.push(route) : context.go(route),
                child: GlassCard(
                  radius: SirajRadiusFull.lg,
                  padding:
                      const EdgeInsets.symmetric(vertical: SirajSpacing.s4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: SirajWhite.w7,
                          borderRadius:
                              BorderRadius.circular(SirajRadiusFull.md),
                          border: Border.all(color: SirajWhite.w7),
                        ),
                        child:
                            Icon(icon, color: SirajWhite.w75, size: 17),
                      ),
                      const SizedBox(height: SirajSpacing.s2),
                      Text(label, textAlign: TextAlign.center,
                          style: AppText.caption
                              .copyWith(fontSize: SirajSizes.sXs)),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
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

/// حقل نجوم متحرك خفيف لسماء الفجر/العشاء - مواضع ثابتة (لا عشوائية
/// حقيقية، بل صيغة مُولَّدة deterministic) تتناسب مع أي حجم شاشة عبر
/// إحداثيات كسرية (0..1)، مع وميض دوري لكل نجمة خامسة فقط (أسوة
/// بمرجع التصميم). رسم بـCustomPainter واحد بدل عشرات الودجتس
/// المنفصلة لأداء أفضل.
class _StarField extends StatefulWidget {
  const _StarField();

  @override
  State<_StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<_StarField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Star> _stars;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _stars = List.generate(70, (i) {
      return _Star(
        dx: (i * 0.1776) % 1.0,
        dy: (i * 0.0991) % 1.0,
        radius: i % 7 == 0 ? 1.3 : (i % 3 == 0 ? 0.9 : 0.55),
        baseOpacity: 0.08 + (i % 9) * 0.09,
        twinkles: i % 5 == 0,
        phase: (i % 7) / 7.0,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary يعزل إعادة الرسم المستمرة (60fps طوال ظهور
    // النجوم) في طبقة Compositor خاصة بها، فلا تُجبر بقية عناصر
    // الـStack (الخلفية المتدرجة، محتوى الشاشة القابل للتمرير) على
    // إعادة الرسم كل frame معها.
    return RepaintBoundary(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _StarFieldPainter(stars: _stars, t: _controller.value),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class _Star {
  final double dx, dy, radius, baseOpacity, phase;
  final bool twinkles;
  const _Star({
    required this.dx,
    required this.dy,
    required this.radius,
    required this.baseOpacity,
    required this.twinkles,
    required this.phase,
  });
}

class _StarFieldPainter extends CustomPainter {
  final List<_Star> stars;
  final double t;
  const _StarFieldPainter({required this.stars, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    for (final star in stars) {
      double opacity = star.baseOpacity;
      if (star.twinkles) {
        final wave = math.sin((t + star.phase) * 2 * math.pi);
        opacity = star.baseOpacity * (0.55 + 0.45 * wave).clamp(0.1, 1.0);
      }
      paint.color = Colors.white.withValues(alpha: opacity.clamp(0.0, 1.0));
      canvas.drawCircle(
        Offset(star.dx * size.width, star.dy * size.height),
        star.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StarFieldPainter oldDelegate) =>
      oldDelegate.t != t;
}

