import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/quran_provider.dart';

class SurahReaderScreen extends ConsumerWidget {
  final int surahId;
  const SurahReaderScreen({super.key, required this.surahId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette    = ref.watch(timeThemeProvider);
    final ayahsAsync = ref.watch(ayahsProvider(surahId));
    final surahsAsync = ref.watch(surahsProvider);

    final surahName = surahsAsync.maybeWhen(
      data: (surahs) => surahs.firstWhere((s) => s.id == surahId).nameArabic,
      orElse: () => '',
    );

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: palette.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          surahName,
          style: TextStyle(
            color: palette.textPrimary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ayahsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => Center(
          child: Text(
            'خطأ في التحميل',
            style: TextStyle(color: palette.textPrimary),
          ),
        ),
        data: (ayahs) => ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: ayahs.length,
          itemBuilder: (context, index) {
            final ayah = ayahs[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Ayah number badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: palette.accentPrimary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${ayah.ayahNumber}',
                          style: TextStyle(
                            color: palette.accentPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Ayah text
                  Text(
                    ayah.textUthmani,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: palette.textPrimary,
                      fontSize: 22,
                      height: 2.0,
                      fontFamily: 'serif',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}