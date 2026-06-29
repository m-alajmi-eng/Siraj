import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/storage/cache_service.dart';
import '../../../prayer/presentation/providers/prayer_provider.dart';
import '../../../calendar/presentation/providers/calendar_provider.dart';
import '../../../calendar/presentation/providers/calendar_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greet(int h) {
    if (h < 5)  return 'ليلة مباركة،';
    if (h < 7)  return 'السلام على الفجر،';
    if (h < 12) return 'صباح الخير،';
    if (h < 15) return 'مساء النور،';
    if (h < 18) return 'عصر مبارك،';
    if (h < 20) return 'مساء الخير،';
    return 'ليلة هادئة،';
  }

  String _monthName(int m) {
    const months = ['','محرم','صفر','ربيع الأول','ربيع الثاني',
      'جمادى الأولى','جمادى الآخرة','رجب','شعبان',
      'رمضان','شوال','ذو القعدة','ذو الحجة'];
    return months[m];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerAsync = ref.watch(prayerTimesProvider);
    final hijriDate   = ref.watch(hijriTodayProvider);
    final nextEvent   = ref.watch(nextEventProvider);
    final lastSurahId = CacheService.getSetting('last_surah_id') as int?;
    final lastAyahNum = CacheService.getSetting('last_ayah_number') as int?;
    final now         = DateTime.now();
    final h           = now.hour;
    final skyColors   = SirajSky.gradientColors(SirajSky.fromHour(h));
    final hijriStr    = '${hijriDate.day} ${_monthName(hijriDate.month)} ${hijriDate.year}هـ';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      backgroundColor: SirajCanvas.base,
      body: Stack(
        children: [
          // Sky
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

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _Header(),
                  const SizedBox(height: 20),
                  _Greeting(
                    greeting:  _greet(h),
                    hijriDate: hijriStr,
                  ),
                  const SizedBox(height: 20),
                  prayerAsync.when(
                    loading: () => const _Skeleton(height: 180),
                    error:   (e, _) => const SizedBox(),
                    data:    (times) => _NextPrayerCard(times: times),
                  ),
                  const SizedBox(height: 12),
                  if (lastSurahId != null) ...[
                    _ContinueReading(
                      surahId:    lastSurahId,
                      ayahNumber: lastAyahNum ?? 1,
                      onTap: () => context.push('/quran/surah/$lastSurahId'),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const _DailyAyah(),
                  const SizedBox(height: 20),
                  const _SectionLabel(label: 'وصول سريع'),
                  const SizedBox(height: 12),
                  _QuickActions(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Floating Search
          Positioned(
            bottom: 16, left: 20, right: 20,
            child: _FloatingSearch(
              onTap: () => context.push('/more/search')),
          ),
        ],
      ),
    ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Glass
// ═══════════════════════════════════════════════════════════
class _Glass extends StatelessWidget {
  final Widget child;
  final double radius;
  final double alpha;
  const _Glass({required this.child, this.radius = 22, this.alpha = 0.068});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color:  Colors.white.withOpacity(alpha),
        border: Border.all(color: Colors.white.withOpacity(0.10), width: 0.5),
        boxShadow: const [
          BoxShadow(color: Color(0x2E000000), blurRadius: 18, offset: Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Section Label
// ═══════════════════════════════════════════════════════════
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3, height: 3,
          decoration: const BoxDecoration(
            color: SirajGold.muted, shape: BoxShape.circle),
        ),
        const SizedBox(width: 7),
        Text(label.toUpperCase(),
          style: TextStyle(
            color:         Colors.white.withOpacity(0.24),
            fontSize:      10,
            letterSpacing: 3.2,
          )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Skeleton
// ═══════════════════════════════════════════════════════════
class _Skeleton extends StatelessWidget {
  final double height;
  const _Skeleton({required this.height});

  @override
  Widget build(BuildContext context) {
    return _Glass(
      radius: 26, alpha: 0.05,
      child: SizedBox(height: height, width: double.infinity),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Header
// ═══════════════════════════════════════════════════════════
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SIRAJ',
              style: TextStyle(
                color:         Colors.white,
                fontWeight:    FontWeight.w300,
                fontSize:      21,
                letterSpacing: 6.0,
              )),
            Text('سراج · Islamic Guidance',
              style: TextStyle(
                color:         Colors.white.withOpacity(0.24),
                fontSize:      10,
                letterSpacing: 1.6,
              )),
          ],
        ),
        Stack(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color:  Colors.white.withOpacity(0.07),
                shape:  BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.09)),
              ),
              child: Icon(Icons.notifications_none_rounded,
                color: Colors.white.withOpacity(0.60), size: 16),
            ),
            Positioned(
              top: 9, right: 9,
              child: Container(
                width: 6, height: 6,
                decoration: BoxDecoration(
                  color:  SirajGold.pure,
                  shape:  BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:      SirajGold.pure.withOpacity(0.6),
                      blurRadius: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Greeting
// ═══════════════════════════════════════════════════════════
class _Greeting extends StatelessWidget {
  final String greeting;
  final String hijriDate;
  const _Greeting({required this.greeting, required this.hijriDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(greeting,
          style: TextStyle(
            color:   Colors.white.withOpacity(0.38),
            fontSize: 13,
          )),
        const SizedBox(height: 2),
        const Text('أهلاً وسهلاً',
          style: TextStyle(
            color:      Colors.white,
            fontWeight: FontWeight.w500,
            fontStyle:  FontStyle.italic,
            fontSize:   29,
            height:     1.22,
          )),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 3, height: 3,
              decoration: const BoxDecoration(
                color: SirajGold.muted, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(hijriDate,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color:    Colors.white.withOpacity(0.40),
                fontSize: 12,
              )),
          ],
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Next Prayer Card
// ═══════════════════════════════════════════════════════════
class _NextPrayerCard extends StatelessWidget {
  final dynamic times;
  const _NextPrayerCard({required this.times});

  @override
  Widget build(BuildContext context) {
    return _Glass(
      radius: 26, alpha: 0.09,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SectionLabel(label: 'الصلاة القادمة'),
            const SizedBox(height: 16),
            Text(times.nextPrayerName ?? '',
              textAlign: TextAlign.right,
              style: TextStyle(
                color:    Colors.white.withOpacity(0.45),
                fontSize: 13,
              )),
            const SizedBox(height: 4),
            Text(times.nextPrayerNameAr ?? '',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color:      Colors.white,
                fontWeight: FontWeight.w600,
                fontSize:   42,
                height:     1.1,
              )),
            const SizedBox(height: 4),
            Text(times.nextPrayerTimeStr,
              textAlign: TextAlign.right,
              style: TextStyle(
                color:      Colors.white.withOpacity(0.75),
                fontSize:   17,
                fontWeight: FontWeight.w500,
              )),
            const SizedBox(height: 16),
            Container(
              height: 1.5,
              decoration: BoxDecoration(
                color:        Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.push('/more/qibla'),
              child: Row(children: [
                Icon(Icons.explore_outlined,
                  color: SirajGold.vivid.withOpacity(0.72), size: 12),
                const SizedBox(width: 4),
                Text('اتجاه القبلة',
                  style: TextStyle(
                    color:    SirajGold.vivid.withOpacity(0.72),
                    fontSize: 11,
                  )),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Continue Reading
// ═══════════════════════════════════════════════════════════
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
    return GestureDetector(
      onTap: onTap,
      child: _Glass(
        radius: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color:        SirajGold.faint,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: SirajGold.subtle),
                ),
                child: const Icon(Icons.menu_book_rounded,
                  color: SirajGold.strong, size: 16),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CONTINUE READING',
                      style: TextStyle(
                        color:         Colors.white.withOpacity(0.22),
                        fontSize:      9,
                        letterSpacing: 2.8,
                      )),
                    const SizedBox(height: 3),
                    Text('سورة #$surahId',
                      style: const TextStyle(
                        color:    Colors.white,
                        fontSize: 15,
                      )),
                    const SizedBox(height: 2),
                    Text('آية $ayahNumber',
                      style: TextStyle(
                        color:    Colors.white.withOpacity(0.32),
                        fontSize: 11,
                      )),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white38, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Daily Ayah
// ═══════════════════════════════════════════════════════════
class _DailyAyah extends StatelessWidget {
  const _DailyAyah();

  @override
  Widget build(BuildContext context) {
    const ayahs = [
      ('أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ القُلُوبُ',
       'Verily, in the remembrance of Allah do hearts find rest.',
       'الرعد ١٣:٢٨'),
      ('إِنَّ مَعَ العُسْرِ يُسْرًا',
       'Indeed, with hardship comes ease.',
       'الشرح ٩٤:٦'),
      ('وَمن يَتَّقِ اللَّهَ يَجْعَل لَّهُ مَخْرَجًا',
       'And whoever fears Allah, He will make for him a way out.',
       'الطلاق ٦٥:٢'),
    ];
    final ayah = ayahs[DateTime.now().day % ayahs.length];

    return _Glass(
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _SectionLabel(label: 'آية اليوم'),
            const SizedBox(height: 16),
            Text(ayah.$1,
              textAlign:     TextAlign.center,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color:    Colors.white,
                fontSize: 22,
                height:   1.8,
              )),
            const SizedBox(height: 12),
            Text('"${ayah.$2}"',
              textAlign: TextAlign.center,
              style: TextStyle(
                color:     Colors.white.withOpacity(0.70),
                fontStyle: FontStyle.italic,
                fontSize:  13,
                height:    1.65,
              )),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: Container(
                height: 0.5,
                color:  Colors.white.withOpacity(0.07))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(ayah.$3,
                  style: TextStyle(
                    color:         Colors.white.withOpacity(0.22),
                    fontSize:      10,
                    letterSpacing: 2.2,
                  )),
              ),
              Expanded(child: Container(
                height: 0.5,
                color:  Colors.white.withOpacity(0.07))),
            ]),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Quick Actions
// ═══════════════════════════════════════════════════════════
class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      (Icons.menu_book_rounded,    'القرآن',        '/quran',                   false),
      (Icons.self_improvement,     'الأذكار',       '/athkar',                  false),
      (Icons.format_quote_rounded, 'الحديث',        '/hadith',                  false),
      (Icons.explore_outlined,     'القبلة',        '/more/qibla',              true),
      (Icons.radio,                'الراديو',       '/more/radio',              true),
      (Icons.calendar_month,       'التقويم',       '/more/calendar',           true),
      (Icons.auto_stories,         'القصص',         '/more/stories',            true),
      (Icons.child_care,           'الأطفال',       '/more/children_stories',   true),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics:    const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:   4,
        crossAxisSpacing: 9,
        mainAxisSpacing:  9,
        childAspectRatio: 0.85,
      ),
      itemCount: actions.length,
      itemBuilder: (_, i) {
        final (icon, label, route, isPush) = actions[i];
        return GestureDetector(
          onTap: () => isPush
              ? context.push(route)
              : context.go(route),
          child: _Glass(
            radius: 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color:        Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.07)),
                    ),
                    child: Icon(icon,
                      color: Colors.white.withOpacity(0.72), size: 17),
                  ),
                  const SizedBox(height: 9),
                  Text(label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:    Colors.white.withOpacity(0.38),
                      fontSize: 10,
                    )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Floating Search
// ═══════════════════════════════════════════════════════════
class _FloatingSearch extends StatelessWidget {
  final VoidCallback onTap;
  const _FloatingSearch({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:        const Color(0xBD08090A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.10)),
          boxShadow: const [
            BoxShadow(
              color:      Color(0x80000000),
              blurRadius: 40,
              offset:     Offset(0, 8)),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search,
              color: Colors.white.withOpacity(0.30), size: 14),
            const SizedBox(width: 12),
            Expanded(
              child: Text('ما الذي تبحث عنه...',
                style: TextStyle(
                  color:    Colors.white.withOpacity(0.22),
                  fontSize: 13,
                )),
            ),
            Row(children: [
              Container(
                width: 3, height: 3,
                decoration: const BoxDecoration(
                  color: SirajGold.muted, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text('بحث',
                style: TextStyle(
                  color:         Colors.white.withOpacity(0.16),
                  fontSize:      10,
                  letterSpacing: 0.8,
                )),
            ]),
          ],
        ),
      ),
    );
  }
}