import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/quran_provider.dart';

class QuranHomeScreen extends ConsumerWidget {
  const QuranHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette     = ref.watch(timeThemeProvider);
    final surahsAsync = ref.watch(surahsProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: palette.background,
        body: SafeArea(
          child: Column(
            children: [
              // ─── Header ───
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'القرآن الكريم',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Surahs List ───
              Expanded(
                child: surahsAsync.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(color: palette.accentPrimary),
                  ),
                  error: (e, _) => Center(
                    child: Text('خطأ في التحميل',
                      style: TextStyle(color: palette.textPrimary)),
                  ),
                  data: (surahs) => ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: surahs.length,
                    itemBuilder: (context, index) {
                      final surah = surahs[index];
                      return GestureDetector(
                        onTap: () => context.go('/quran/surah/${surah.id}'),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color:        palette.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              // اسم السورة بالعربي + عدد الآيات (يمين)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      surah.nameArabic,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color:    palette.textPrimary,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${surah.ayahCount} آية',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color:    palette.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 14),
                              // الاسم اللاتيني + النوع (وسط)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    surah.nameTransliteration,
                                    style: TextStyle(
                                      color:      palette.textPrimary,
                                      fontSize:   15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    surah.revelationType == 'Meccan' ? 'مكية' : 'مدنية',
                                    style: TextStyle(
                                      color:    palette.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              // رقم السورة (يسار)
                              Container(
                                width:  36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: palette.accentPrimary.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${surah.id}',
                                    style: TextStyle(
                                      color:      palette.accentPrimary,
                                      fontSize:   13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
