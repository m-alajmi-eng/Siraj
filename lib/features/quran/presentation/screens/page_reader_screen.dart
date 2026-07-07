import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/quran_provider.dart';
import '../../data/datasources/surah_names_datasource.dart';
import '../../../khatmah/presentation/providers/khatmah_provider.dart';

/// وضع قراءة الصفحات: يعرض صفحات المصحف الحقيقية (1..604).
/// يدعم اختيارياً ربطاً بختمة (khatmahId) لتسجيل التقدّم عند القراءة.
class PageReaderScreen extends ConsumerStatefulWidget {
  final int initialPage;
  final String? khatmahId;

  const PageReaderScreen({super.key, this.initialPage = 1, this.khatmahId});

  @override
  ConsumerState<PageReaderScreen> createState() => _PageReaderScreenState();
}

class _PageReaderScreenState extends ConsumerState<PageReaderScreen> {
  static const int _totalPages = 604;
  late final PageController _controller;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage.clamp(1, _totalPages);
    // PageView index 0 = صفحة 1
    _controller = PageController(initialPage: _currentPage - 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    final page = index + 1;
    setState(() => _currentPage = page);
    // تسجيل التقدّم في الختمة إن كانت مرتبطة (وصل لهذه الصفحة)
    if (widget.khatmahId != null) {
      ref.read(khatmahProvider.notifier).recordProgress(widget.khatmahId!, page);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.background,
        elevation: 0,
        iconTheme: IconThemeData(color: palette.textPrimary),
        title: Text(
          '${t.khatmah_page} $_currentPage / $_totalPages',
          style: AppText.body.copyWith(
              color: palette.textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          // اتجاه المصحف: التمرير لليمين ينتقل للصفحة التالية (RTL)
          reverse: true,
          itemCount: _totalPages,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            final pageNumber = index + 1;
            return _PageContent(pageNumber: pageNumber, palette: palette);
          },
        ),
      ),
    );
  }
}

/// محتوى صفحة مصحف واحدة: يجلب آياتها ويعرضها كنص متدفّق بصيغة ﴿رقم﴾.
class _PageContent extends ConsumerWidget {
  final int pageNumber;
  final dynamic palette;

  const _PageContent({required this.pageNumber, required this.palette});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayahsAsync = ref.watch(pageAyahsProvider(pageNumber));

    return ayahsAsync.when(
      loading: () => Center(
        child: CircularProgressIndicator(color: palette.accentPrimary),
      ),
      error: (e, _) => Center(
        child: Text('—', style: TextStyle(color: palette.textSecondary)),
      ),
      data: (ayahs) {
        // نجمّع الآيات، ونُظهر اسم السورة عند بدايتها داخل الصفحة
        final spans = <InlineSpan>[];
        int? lastSurah;
        for (final a in ayahs) {
          final surahId = a['surahId'] as int;
          final ayahNumber = a['ayahNumber'] as int;
          final text = a['text'] as String;

          // عنوان السورة عند أول ظهور لها في الصفحة
          if (surahId != lastSurah) {
            lastSurah = surahId;
            final surahName = SurahNamesDataSource.arabicNameSync(surahId);
            spans.add(TextSpan(
              text: '\n${surahName.isNotEmpty ? surahName : 'سورة $surahId'}\n\n',
              style: TextStyle(
                fontFamily: 'QuranFont',
                color: palette.accentPrimary,
                fontSize: 22,
                height: 2.2,
                fontWeight: FontWeight.w600,
              ),
            ));
          }

          spans.add(TextSpan(
            text: '$text ',
            style: TextStyle(
              fontFamily: 'QuranFont',
              color: palette.textPrimary,
              fontSize: 26,
              height: 2.4,
            ),
          ));
          spans.add(TextSpan(
            text: ' ﴿${_toArabicNumeral(ayahNumber)}﴾ ',
            style: TextStyle(
              fontFamily: 'QuranFont',
              color: palette.accentPrimary,
              fontSize: 22,
              height: 2.4,
            ),
          ));
        }

        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
          padding: const EdgeInsets.all(SirajSpacing.s5),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
          ),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(children: spans),
              ),
            ),
          ),
        );
      },
    );
  }

  String _toArabicNumeral(int number) {
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.toString().split('').map((d) => arabic[int.parse(d)]).join();
  }
}
