import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/cache_service.dart';

class SpiritualStats {
  final int prayerStreak;
  final int totalPrayers;
  final int quranPagesRead;
  final int athkarCompleted;
  final int quranKhatma;

  const SpiritualStats({
    this.prayerStreak    = 0,
    this.totalPrayers    = 0,
    this.quranPagesRead  = 0,
    this.athkarCompleted = 0,
    this.quranKhatma     = 0,
  });
}

class StatsNotifier extends Notifier<SpiritualStats> {
  @override
  SpiritualStats build() {
    return SpiritualStats(
      prayerStreak:    CacheService.getSetting('prayer_streak',    defaultValue: 0),
      totalPrayers:    CacheService.getSetting('total_prayers',    defaultValue: 0),
      quranPagesRead:  CacheService.getSetting('quran_pages',      defaultValue: 0),
      athkarCompleted: CacheService.getSetting('athkar_completed', defaultValue: 0),
      quranKhatma:     CacheService.getSetting('quran_khatma',     defaultValue: 0),
    );
  }

  Future<void> logPrayer() async {
    await CacheService.saveSetting(
      'total_prayers', state.totalPrayers + 1);
    final lastPrayer = CacheService.getSetting('last_prayer_date');
    final today      = DateTime.now().toIso8601String().substring(0, 10);
    int streak       = state.prayerStreak;

    if (lastPrayer == null) {
      streak = 1;
    } else {
      final diff = DateTime.now()
          .difference(DateTime.parse(lastPrayer))
          .inDays;
      streak = diff <= 1 ? streak + 1 : 1;
    }

    await CacheService.saveSetting('last_prayer_date', today);
    await CacheService.saveSetting('prayer_streak',    streak);
    state = SpiritualStats(
      prayerStreak:    streak,
      totalPrayers:    state.totalPrayers + 1,
      quranPagesRead:  state.quranPagesRead,
      athkarCompleted: state.athkarCompleted,
      quranKhatma:     state.quranKhatma,
    );
  }

  Future<void> logAthkar() async {
    final count = state.athkarCompleted + 1;
    await CacheService.saveSetting('athkar_completed', count);
    state = SpiritualStats(
      prayerStreak:    state.prayerStreak,
      totalPrayers:    state.totalPrayers,
      quranPagesRead:  state.quranPagesRead,
      athkarCompleted: count,
      quranKhatma:     state.quranKhatma,
    );
  }

  Future<void> logQuranPage() async {
    final pages = state.quranPagesRead + 1;
    final khatma = pages ~/ 604;
    await CacheService.saveSetting('quran_pages',  pages);
    await CacheService.saveSetting('quran_khatma', khatma);
    state = SpiritualStats(
      prayerStreak:    state.prayerStreak,
      totalPrayers:    state.totalPrayers,
      quranPagesRead:  pages,
      athkarCompleted: state.athkarCompleted,
      quranKhatma:     khatma,
    );
  }
}

final statsProvider = NotifierProvider<StatsNotifier, SpiritualStats>(() {
  return StatsNotifier();
});