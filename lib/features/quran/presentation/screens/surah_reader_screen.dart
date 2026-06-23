import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/audio/audio_provider.dart';
import '../providers/quran_provider.dart';

class SurahReaderScreen extends ConsumerWidget {
  final int surahId;
  const SurahReaderScreen({super.key, required this.surahId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette     = ref.watch(timeThemeProvider);
    final ayahsAsync  = ref.watch(ayahsProvider(surahId));
    final surahsAsync = ref.watch(surahsProvider);
    final audioState  = ref.watch(audioProvider);

    final surah = surahsAsync.maybeWhen(
      data: (surahs) => surahs.firstWhere((s) => s.id == surahId),
      orElse: () => null,
    );

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [

            // ─── Header ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: palette.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          surah?.nameArabic ?? '',
                          style: TextStyle(
                            color: palette.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          surah != null
                            ? '${surah.revelationType == 'Meccan' ? 'مكية' : 'مدنية'} · ${surah.ayahCount} آية'
                            : '',
                          style: TextStyle(
                            color: palette.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // ─── Audio Player Bar ──────────────────────────────
            ayahsAsync.maybeWhen(
              data: (ayahs) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: palette.accentPrimary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (audioState.isPlaying &&
                            audioState.currentSurahId == surahId) {
                          ref.read(audioProvider.notifier).pause();
                        } else {
                          ref.read(audioProvider.notifier).playAyah(
                            surahId, 1,
                            totalAyahs: ayahs.length,
                          );
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: palette.accentPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          audioState.isPlaying &&
                          audioState.currentSurahId == surahId
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: palette.surface,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            audioState.isPlaying &&
                            audioState.currentSurahId == surahId
                                ? 'الآية ${audioState.currentAyahId}'
                                : 'اضغط للاستماع',
                            style: TextStyle(
                              color: palette.textPrimary,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'مشاري راشد العفاسي',
                            style: TextStyle(
                              color: palette.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),

            const SizedBox(height: 12),

            // ─── Quran Text ───────────────────────────────────
            Expanded(
              child: ayahsAsync.when(
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: palette.accentPrimary),
                ),
                error: (e, _) => Center(
                  child: Text('خطأ في التحميل',
                    style: TextStyle(color: palette.textPrimary)),
                ),
                data: (ayahs) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: ayahs.length,
                    itemBuilder: (context, index) {
                      final ayah = ayahs[index];
                      final isCurrentAyah =
                          audioState.currentSurahId == surahId &&
                          audioState.currentAyahId  == ayah.ayahNumber;

                      return Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: ayah.textUthmani,
                                    style: TextStyle(
                                      fontFamily: 'QuranFont',
                                      color: isCurrentAyah
                                          ? palette.accentPrimary
                                          : palette.textPrimary,
                                      fontSize: 26,
                                      height: 2.5,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: palette.accentPrimary
                                            .withOpacity(0.15),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '${ayah.ayahNumber}',
                                        style: TextStyle(
                                          color: palette.accentPrimary,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (index < ayahs.length - 1)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _DiamondDivider(
                                    color: palette.accentPrimary
                                        .withOpacity(0.3)),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _DiamondDivider extends StatelessWidget {
  final Color color;
  const _DiamondDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 40, height: 0.5, color: color),
        const SizedBox(width: 6),
        Transform.rotate(
          angle: 0.785,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Container(width: 40, height: 0.5, color: color),
      ],
    );
  }
}