import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/audio/audio_provider.dart';
import '../../../../core/audio/audio_service.dart';
import '../../../../core/storage/cache_service.dart';
import '../providers/quran_provider.dart';
import '../../../qke/presentation/screens/verse_portal_screen.dart';
import '../../data/datasources/quran_remote_datasource.dart';

class SurahReaderScreen extends ConsumerStatefulWidget {
  final int surahId;
  const SurahReaderScreen({super.key, required this.surahId});

  @override
  ConsumerState<SurahReaderScreen> createState() => _SurahReaderScreenState();
}

class _SurahReaderScreenState extends ConsumerState<SurahReaderScreen> {
  static const int _basmalaLength = 39;

  @override
  void initState() {
    super.initState();
    CacheService.saveSetting("last_surah_id", widget.surahId);
  }

  @override
  Widget build(BuildContext context) {
    final t               = AppLocalizations.of(context);
    final palette         = ref.watch(timeThemeProvider);
    final ayahsAsync      = ref.watch(ayahsProvider(widget.surahId));
    final surahsAsync     = ref.watch(surahsProvider);
    final audioState      = ref.watch(audioProvider);
    final selectedReciter = ref.watch(selectedReciterProvider);

    final surah = surahsAsync.maybeWhen(
      data: (surahs) => surahs.firstWhere((s) => s.id == widget.surahId),
      orElse: () => null,
    );

    final reciterName = SirajAudioService.reciters.entries
        .firstWhere(
          (e) => e.value == selectedReciter,
          orElse: () => const MapEntry('مشاري راشد العفاسي', 'Alafasy_128kbps'),
        )
        .key;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(audioProvider.notifier).stopAudio();
          if (audioState.currentAyahId != null) {
            CacheService.saveReadingPosition(widget.surahId, audioState.currentAyahId!);
          }
        }
      },
      child: Scaffold(
        backgroundColor: palette.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: palette.textPrimary),
                      onPressed: () {
                        ref.read(audioProvider.notifier).stopAudio();
                        if (audioState.currentAyahId != null) {
                          CacheService.saveReadingPosition(
                            widget.surahId, audioState.currentAyahId!);
                        }
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(surah?.nameArabic ?? '',
                            style: TextStyle(
                              fontFamily: 'QuranFont',
                              color: palette.textPrimary,
                              fontSize: 28)),
                          Text(
                            surah != null
                                ? '${surah.revelationType == 'Meccan' ? t.quran_meccan : t.quran_medinan} · ${t.quran_ayahCount(surah.ayahCount)}'
                                : '',
                            style: TextStyle(color: palette.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              ayahsAsync.maybeWhen(
                data: (ayahs) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: palette.accentPrimary.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (audioState.isPlaying &&
                              audioState.currentSurahId == widget.surahId) {
                            ref.read(audioProvider.notifier).pause();
                          } else if (!audioState.isPlaying &&
                              audioState.currentSurahId == widget.surahId &&
                              audioState.currentAyahId != null) {
                            ref.read(audioProvider.notifier).resume();
                          } else {
                            ref.read(audioProvider.notifier).playFromStart(
                              widget.surahId, ayahs.length, selectedReciter,
                              surahName: surah?.nameArabic ?? '');
                          }
                        },
                        child: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: palette.accentPrimary, shape: BoxShape.circle),
                          child: Icon(
                            audioState.isPlaying &&
                                audioState.currentSurahId == widget.surahId
                                ? Icons.pause : Icons.play_arrow,
                            color: palette.surface, size: 22),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              audioState.isPlaying &&
                                  audioState.currentSurahId == widget.surahId
                                  ? t.reader_ayahNum(audioState.currentAyahId ?? 0)
                                  : t.reader_tapToListen,
                              style: TextStyle(color: palette.textPrimary, fontSize: 13)),
                            Text(reciterName,
                              style: TextStyle(color: palette.accentPrimary, fontSize: 11)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showReciterPicker(context, palette, ayahs.length, t),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: palette.accentPrimary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Icon(Icons.mic, color: palette.accentPrimary, size: 14),
                              const SizedBox(width: 4),
                              Text(t.reader_reciter,
                                style: TextStyle(color: palette.accentPrimary, fontSize: 11)),
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

              Expanded(
                child: ayahsAsync.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(color: palette.accentPrimary)),
                  error: (e, _) => Center(
                    child: Text(t.common_error,
                      style: TextStyle(color: palette.textPrimary))),
                  data: (ayahs) {
                    final firstText = ayahs.isNotEmpty ? ayahs[0].textUthmani : '';
                    final separateBasmala = widget.surahId != 9 &&
                        firstText.length >= _basmalaLength;
                    final basmalaText = separateBasmala
                        ? firstText.substring(0, _basmalaLength).trim() : '';
                    final firstAyahText = separateBasmala
                        ? firstText.substring(_basmalaLength).trim() : firstText;

                    final surahName = surahsAsync.maybeWhen(
                      data: (s) => s.firstWhere((su) => su.id == widget.surahId).nameArabic,
                      orElse: () => '',
                    );

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(16)),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: ayahs.length + (separateBasmala ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (separateBasmala && index == 0) {
                            return Column(
                              children: [
                                Text(basmalaText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'QuranFont',
                                    color: palette.accentPrimary,
                                    fontSize: 24, height: 2.0)),
                                Divider(
                                  color: palette.accentPrimary.withValues(alpha: 0.2),
                                  thickness: 0.5, height: 20),
                              ],
                            );
                          }

                          final ayahIndex = separateBasmala ? index - 1 : index;
                          final ayah = ayahs[ayahIndex];
                          final text = (ayahIndex == 0 && separateBasmala)
                              ? firstAyahText : ayah.textUthmani;
                          final isCurrentAyah =
                              audioState.currentSurahId == widget.surahId &&
                              audioState.currentAyahId == ayah.ayahNumber;

                          return GestureDetector(
                            onLongPress: () => _showAyahOptions(
                              context: context, palette: palette, t: t,
                              surahId: widget.surahId, surahName: surahName,
                              ayahNumber: ayah.ayahNumber, ayahText: text),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.all(isCurrentAyah ? 8 : 0),
                              decoration: BoxDecoration(
                                color: isCurrentAyah
                                    ? palette.accentPrimary.withValues(alpha: 0.08)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(isCurrentAyah ? 10 : 0)),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: text,
                                        style: TextStyle(
                                          fontFamily: 'QuranFont',
                                          color: isCurrentAyah
                                              ? palette.accentPrimary
                                              : palette.textPrimary,
                                          fontSize: 26, height: 2.2)),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 4),
                                          width: 28, height: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isCurrentAyah
                                                ? palette.accentPrimary
                                                : palette.accentPrimary.withValues(alpha: 0.15)),
                                          child: Center(
                                            child: Text(_toArabicNumeral(ayah.ayahNumber),
                                              style: TextStyle(
                                                color: isCurrentAyah
                                                    ? palette.surface
                                                    : palette.accentPrimary,
                                                fontSize: 10, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (ayah.translation != null) ...[
                                const SizedBox(height: 10),
                                Text(ayah.translation!,
                                  style: TextStyle(
                                    color: palette.textSecondary,
                                    fontSize: 15, height: 1.6)),
                              ],
                              ]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: Text(t.reader_longPressHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: palette.textSecondary, fontSize: 11)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAyahOptions({
    required BuildContext context,
    required dynamic palette,
    required AppLocalizations t,
    required int surahId,
    required String surahName,
    required int ayahNumber,
    required String ayahText,
  }) {
    CacheService.saveSetting('last_surah_id', surahId);
    CacheService.saveSetting('last_ayah_number', ayahNumber);
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: palette.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Text('${t.reader_ayahNum(ayahNumber)} · $surahName',
              style: TextStyle(
                color: palette.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.auto_awesome, color: palette.accentPrimary),
              title: Text(t.reader_versePortal,
                textAlign: TextAlign.right, style: TextStyle(color: palette.textPrimary)),
              subtitle: Text(t.reader_portalSub,
                textAlign: TextAlign.right,
                style: TextStyle(color: palette.textSecondary, fontSize: 12)),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (_, __, ___) => VersePortalScreen(
                      surahId: surahId, ayahNumber: ayahNumber),
                    transitionsBuilder: (_, animation, __, child) =>
                        FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation, curve: Curves.easeInOut),
                          child: child),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.auto_stories, color: palette.accentPrimary),
              title: Text(t.reader_showTafsir,
                textAlign: TextAlign.right, style: TextStyle(color: palette.textPrimary)),
              onTap: () {
                Navigator.pop(ctx);
                _showTafsir(context, palette, surahId, ayahNumber, t);
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: palette.accentPrimary),
              title: Text(t.reader_shareAyah,
                textAlign: TextAlign.right, style: TextStyle(color: palette.textPrimary)),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/more/share', extra: {
                  'title': t.reader_shareTitle,
                  'subtitle': t.reader_shareSubtitle(surahName, ayahNumber),
                  'content': ayahText,
                  'type': 'quran',
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.copy, color: palette.accentPrimary),
              title: Text(t.reader_copyAyah,
                textAlign: TextAlign.right, style: TextStyle(color: palette.textPrimary)),
              onTap: () {
                Navigator.pop(ctx);
                Clipboard.setData(ClipboardData(text: ayahText));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.reader_ayahCopied),
                    duration: const Duration(seconds: 2)),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showTafsir(BuildContext context, dynamic palette, int surahId,
      int ayahNumber, AppLocalizations t) {
    final dataSource = QuranRemoteDataSource();
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: palette.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(t.reader_tafsirOf(ayahNumber),
                  style: TextStyle(
                    color: palette.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: palette.accentPrimary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8)),
                  child: Text(t.reader_muyassar,
                    style: TextStyle(color: palette.accentPrimary, fontSize: 11)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<String>(
                future: dataSource.getTafsir(surahId, ayahNumber),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: palette.accentPrimary));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(t.reader_tafsirError,
                        style: TextStyle(color: palette.textSecondary)));
                  }
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(snapshot.data ?? '',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: palette.textPrimary, fontSize: 16, height: 1.8)),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _toArabicNumeral(int number) {
    const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
    return number.toString().split('').map((d) => arabic[int.parse(d)]).join();
  }

  void _showReciterPicker(BuildContext context, dynamic palette,
      int totalAyahs, AppLocalizations t) {
    final searchController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          final allReciters = SirajAudioService.reciters.entries.toList();
          final filtered = searchController.text.isEmpty
              ? allReciters
              : allReciters.where((e) => e.key.contains(searchController.text)).toList();

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
                        color: palette.textSecondary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 16),
                    Text(t.reader_chooseReciter,
                      style: TextStyle(
                        color: palette.textPrimary, fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(color: palette.textPrimary),
                        decoration: InputDecoration(
                          hintText: t.reader_searchReciter,
                          hintStyle: TextStyle(color: palette.textSecondary),
                          prefixIcon: Icon(Icons.search, color: palette.textSecondary),
                          filled: true,
                          fillColor: palette.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
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
                            title: Text(entry.key,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: isSelected
                                    ? palette.accentPrimary : palette.textPrimary,
                                fontSize: 15)),
                            trailing: isSelected
                                ? Icon(Icons.check, color: palette.accentPrimary)
                                : null,
                            onTap: () {
                              ref.read(selectedReciterProvider.notifier).select(entry.value);
                              Navigator.pop(context);
                              ref.read(audioProvider.notifier).changeReciter(entry.value);
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