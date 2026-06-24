import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/audio/audio_provider.dart';
import '../../../../core/audio/audio_service.dart';
import '../providers/quran_provider.dart';

class SurahReaderScreen extends ConsumerWidget {
  final int surahId;
  const SurahReaderScreen({super.key, required this.surahId});

  static const int _basmalaLength = 39;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette         = ref.watch(timeThemeProvider);
    final ayahsAsync      = ref.watch(ayahsProvider(surahId));
    final surahsAsync     = ref.watch(surahsProvider);
    final audioState      = ref.watch(audioProvider);
    final selectedReciter = ref.watch(selectedReciterProvider);

    final surah = surahsAsync.maybeWhen(
      data: (surahs) => surahs.firstWhere((s) => s.id == surahId),
      orElse: () => null,
    );

    final reciterName = SirajAudioService.reciters.entries
        .firstWhere(
          (e) => e.value == selectedReciter,
          orElse: () => const MapEntry(
            'مشاري راشد العفاسي', 'Alafasy_128kbps'),
        )
        .key;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) ref.read(audioProvider.notifier).stopAudio();
      },
      child: Scaffold(
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
                      onPressed: () {
                        ref.read(audioProvider.notifier).stopAudio();
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            surah?.nameArabic ?? '',
                            style: TextStyle(
                              fontFamily: 'QuranFont',
                              color: palette.textPrimary,
                              fontSize: 28,
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
                          } else if (!audioState.isPlaying &&
                              audioState.currentSurahId == surahId &&
                              audioState.currentAyahId != null) {
                            ref.read(audioProvider.notifier).resume();
                          } else {
                            ref.read(audioProvider.notifier).playFromStart(
                              surahId, ayahs.length, selectedReciter,
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
                              reciterName,
                              style: TextStyle(
                                color: palette.accentPrimary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showReciterPicker(
                          context, ref, palette, ayahs.length),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: palette.accentPrimary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.mic,
                                color: palette.accentPrimary, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'القارئ',
                                style: TextStyle(
                                  color: palette.accentPrimary,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
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
                  data: (ayahs) {
                    final firstText =
                        ayahs.isNotEmpty ? ayahs[0].textUthmani : '';
                    final separateBasmala = surahId != 9 &&
                        firstText.length >= _basmalaLength;
                    final basmalaText = separateBasmala
                        ? firstText.substring(0, _basmalaLength).trim()
                        : '';
                    final firstAyahText = separateBasmala
                        ? firstText.substring(_basmalaLength).trim()
                        : firstText;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              // البسملة في سطر منفصل
                              if (separateBasmala) ...[
                                Text(
                                  basmalaText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'QuranFont',
                                    color: palette.accentPrimary,
                                    fontSize: 24,
                                    height: 2.0,
                                  ),
                                ),
                                Divider(
                                  color: palette.accentPrimary
                                      .withOpacity(0.2),
                                  thickness: 0.5,
                                  height: 20,
                                ),
                              ],

                              // الآيات متدفقة
                              RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  children: _buildSpans(
                                    ayahs,
                                    audioState,
                                    surahId,
                                    palette,
                                    separateBasmala,
                                    firstAyahText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  List<InlineSpan> _buildSpans(
    List ayahs,
    AudioState audioState,
    int surahId,
    dynamic palette,
    bool separateBasmala,
    String firstAyahText,
  ) {
    final spans = <InlineSpan>[];

    for (int i = 0; i < ayahs.length; i++) {
      final ayah = ayahs[i];
      final isCurrentAyah =
          audioState.currentSurahId == surahId &&
          audioState.currentAyahId  == ayah.ayahNumber;

      final text = (i == 0 && separateBasmala)
          ? firstAyahText
          : ayah.textUthmani;

      if (text.trim().isEmpty) continue;

      spans.add(TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: 'QuranFont',
          color: isCurrentAyah
              ? palette.accentPrimary
              : palette.textPrimary,
          fontSize: 26,
          height: 2.2,
          background: isCurrentAyah
              ? (Paint()
                ..color = palette.accentPrimary.withOpacity(0.08)
                ..style = PaintingStyle.fill)
              : null,
        ),
      ));

      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 28, height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrentAyah
                ? palette.accentPrimary
                : palette.accentPrimary.withOpacity(0.15),
          ),
          child: Center(
            child: Text(
              _toArabicNumeral(ayah.ayahNumber),
              style: TextStyle(
                color: isCurrentAyah
                    ? palette.surface
                    : palette.accentPrimary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ));

      spans.add(const TextSpan(text: ' '));
    }

    return spans;
  }

  String _toArabicNumeral(int number) {
    const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
    return number.toString()
        .split('')
        .map((d) => arabic[int.parse(d)])
        .join();
  }

  void _showReciterPicker(
    BuildContext context,
    WidgetRef ref,
    dynamic palette,
    int totalAyahs,
  ) {
    final searchController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          final allReciters = SirajAudioService.reciters.entries.toList();
          final filtered = searchController.text.isEmpty
              ? allReciters
              : allReciters
                  .where((e) => e.key.contains(searchController.text))
                  .toList();

          return Consumer(
            builder: (context, ref, _) {
              final selected = ref.watch(selectedReciterProvider);

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(
                        color: palette.textSecondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'اختر القارئ',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: searchController,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: palette.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'ابحث عن قارئ...',
                          hintStyle: TextStyle(
                            color: palette.textSecondary),
                          prefixIcon: Icon(Icons.search,
                            color: palette.textSecondary),
                          filled: true,
                          fillColor: palette.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final entry = filtered[index];
                          final isSelected = selected == entry.value;

                          return ListTile(
                            title: Text(
                              entry.key,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: isSelected
                                    ? palette.accentPrimary
                                    : palette.textPrimary,
                                fontSize: 15,
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(Icons.check,
                                    color: palette.accentPrimary)
                                : null,
                            onTap: () {
                              ref
                                  .read(selectedReciterProvider.notifier)
                                  .select(entry.value);
                              Navigator.pop(context);
                              // إعادة التشغيل من البداية مع البسملة
                              ref.read(audioProvider.notifier).playFromStart(
                                surahId, totalAyahs, entry.value,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}