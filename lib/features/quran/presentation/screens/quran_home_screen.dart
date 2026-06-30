import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/quran_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../data/datasources/surah_names_datasource.dart';

class QuranHomeScreen extends ConsumerWidget {
  const QuranHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t           = AppLocalizations.of(context);
    final palette     = ref.watch(timeThemeProvider);
    final surahsAsync = ref.watch(surahsProvider);
    final lang        = ref.watch(localeProvider).languageCode;
    ref.watch(surahNamesLoadedProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SirajLayout.pagePadding, vertical: SirajSpacing.s4),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(t.quran_title, style: AppText.title.copyWith(
                  color: palette.textPrimary)),
              ),
            ),
            Expanded(
              child: surahsAsync.when(
                loading: () => Center(
                  child: CircularProgressIndicator(color: palette.accentPrimary),
                ),
                error: (e, _) => Center(
                  child: Text(t.common_error, style: AppText.body.copyWith(
                    color: palette.textPrimary)),
                ),
                data: (surahs) => ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SirajLayout.pagePadding),
                  itemCount: surahs.length,
                  itemBuilder: (context, index) {
                    final surah = surahs[index];
                    return _SurahTile(
                      surah:   surah,
                      palette: palette,
                      lang:    lang,
                      typeLabel: surah.revelationType == 'Meccan'
                          ? t.quran_meccan : t.quran_medinan,
                      ayahLabel: t.quran_ayahCount(surah.ayahCount),
                      onTap: () => context.go('/quran/surah/${surah.id}'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SurahTile extends StatelessWidget {
  final dynamic surah;
  final dynamic palette;
  final String typeLabel;
  final String ayahLabel;
  final String lang;
  final VoidCallback onTap;

  const _SurahTile({
    required this.surah,
    required this.palette,
    required this.typeLabel,
    required this.ayahLabel,
    required this.lang,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final arabicName = SurahNamesDataSource.arabicNameSync(surah.id);
    final localName  = SurahNamesDataSource.localizedNameSync(surah.id, lang);
    final displayArabic = arabicName.isNotEmpty ? arabicName : surah.nameArabic;
    final displayLocal  = localName.isNotEmpty ? localName : surah.nameTransliteration;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
        padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s4, vertical: SirajSpacing.s4),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              // رقم السورة (يمين)
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: palette.accentPrimary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${surah.id}', style: AppText.numeral.copyWith(
                    color: palette.accentPrimary, fontSize: SirajSizes.sBase,
                    fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: SirajSpacing.s4),
              // الاسم العربي + عدد الآيات (يمين، بعد الرقم)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(displayArabic, style: AppText.quran.copyWith(
                    color: palette.textPrimary, fontSize: SirajSizes.sXl,
                    height: 1.4)),
                  Text(ayahLabel, style: AppText.caption.copyWith(
                    color: palette.textSecondary)),
                ],
              ),
              const Spacer(),
              // الاسم المترجم + النوع (يسار) — يظهر فقط لغير العربية
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (lang != 'ar')
                    Text(displayLocal, style: AppText.body.copyWith(
                      color: palette.textPrimary, fontWeight: FontWeight.w500)),
                  Text(typeLabel, style: AppText.caption.copyWith(
                    color: palette.textSecondary)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
