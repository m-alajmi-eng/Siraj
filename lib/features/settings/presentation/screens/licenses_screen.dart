import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';

/// شاشة التراخيص داخل التطبيق: تجمع كل تراخيص المحتوى والخطوط والحزم
/// الفعلية المستخدَمة في سراج. كل نص هنا مصدره حقيقي (مستخرَج من ملفات
/// الخطوط نفسها أو ملف LICENSE للحزمة) — لا نص مُخترَع. البنود التي لم
/// يُحسم ترخيصها بعد (راجع docs/02_STORE_COMPLIANCE.md وdocs/06_RISK_REGISTER.md)
/// تُعرض بصراحة كـ"قيد المراجعة"، لا كمُلغّى أو مُخفى.
class LicensesScreen extends ConsumerWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final t = AppLocalizations.of(context);

    return AppScaffold(
      title: t.settings_licenses,
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: SirajSpacing.s2),
          _LicenseCard(
            palette: palette,
            icon: Icons.font_download_outlined,
            title: 'خطوط مجمّع الملك فهد لطباعة المصحف الشريف (KFGQPC)',
            subtitle: 'HafsSmart_08.ttf · UthmanTNB_v2-0.ttf — رخصة مستخدم نهائي (EULA)',
            body: _kfgqpcEula,
          ),
          _LicenseCard(
            palette: palette,
            icon: Icons.font_download_outlined,
            title: 'خطوط برخصة SIL Open Font License 1.1',
            subtitle: 'Scheherazade New (المضمّن باسم QuranFont.ttf) · Amiri · '
                'Noto Sans · Noto Sans Arabic',
            body: _silOfl,
          ),
          _LicenseCard(
            palette: palette,
            icon: Icons.info_outline,
            title: 'مصادر محتوى ديني خارجية',
            subtitle: 'IslamHouse / HadeethEnc.com · التفسير الميسّر · بيانات التجويد الملوّن',
            body: 'هذه المصادر تُستخدَم حالياً في التطبيق، لكن ترخيصها '
                'الرسمي الكامل **لم يُحسم توثيقه بعد** من قِبل فريق سراج '
                '(بند مفتوح موثَّق في سجلّي المخاطر والامتثال الداخليَين). '
                'لا يُعرض هنا أي نص ترخيص لأنه غير محسوم فعلياً — هذا وصف '
                'صادق للحالة الراهنة، لا إخفاء لها.',
            pending: true,
          ),
          _LicenseCard(
            palette: palette,
            icon: Icons.radio_outlined,
            title: 'محطات البث الإذاعي',
            subtitle: 'راجع شاشة الراديو',
            body: 'ترخيص إعادة بث محطات القرآن الكريم داخل التطبيق يتطلّب '
                'تواصلاً بشرياً مباشراً مع كل محطة، ولم يتم بعد. بند مفتوح '
                'بأولوية عالية (P0) في سجلّ الامتثال الداخلي.',
            pending: true,
          ),
          const SizedBox(height: SirajSpacing.s3),
          _PackagesTile(palette: palette),
          const SizedBox(height: SirajSpacing.s8),
        ],
      ),
    );
  }
}

class _LicenseCard extends StatelessWidget {
  final dynamic palette;
  final IconData icon;
  final String title;
  final String subtitle;
  final String body;
  final bool pending;

  const _LicenseCard({
    required this.palette,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.body,
    this.pending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(SirajRadiusFull.md),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(icon, color: palette.accentPrimary, size: 20),
          title: Text(title, style: AppText.body.copyWith(
              color: palette.textPrimary, fontWeight: FontWeight.w700)),
          subtitle: Row(
            children: [
              if (pending)
                Container(
                  margin: const EdgeInsets.only(top: 4, left: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                  ),
                  child: const Text('قيد المراجعة',
                      style: TextStyle(fontSize: 10, color: Colors.orange)),
                ),
              Expanded(
                child: Text(subtitle, style: AppText.caption.copyWith(
                    color: palette.textSecondary)),
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
              SirajSpacing.s4, 0, SirajSpacing.s4, SirajSpacing.s4),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              body,
              style: AppText.bodySmall.copyWith(color: palette.textSecondary, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackagesTile extends StatelessWidget {
  final dynamic palette;
  const _PackagesTile({required this.palette});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => showLicensePage(
        context: context,
        applicationName: 'سراج',
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: SirajSpacing.s4, vertical: SirajSpacing.s4),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
        ),
        child: Row(
          children: [
            Icon(Icons.inventory_2_outlined, color: palette.accentPrimary, size: 20),
            const SizedBox(width: SirajSpacing.s3),
            Expanded(
              child: Text(t.settings_openSourcePackages,
                  style: AppText.body.copyWith(color: palette.textPrimary)),
            ),
            Icon(Icons.chevron_right, color: palette.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}

// النصوص التالية مستخرجة حرفياً (verbatim) من ملفات الخطوط الفعلية
// المضمّنة في assets/fonts/ عبر فحص جدول "name" في كل ملف. لا تُترجَم —
// الترخيص يشترط نصاً أصلياً غير معدَّل.

const String _kfgqpcEula = '''
ELECTRONIC END-USER LICENSE AGREEMENT

By installing this Font You accept all the terms and conditions of this Agreement.

Copyright (c) 2017 by King Fahd Glorious Quran Printing Complex (KFGQPC), AlMadinah AlMunawarrah, Kingdom of Saudi Arabia. All Rights Reserved. KFGQPC retains full title and ownership of this Typeface both as artwork and font software. This Agreement does not grant you any intellectual property rights in the Font.

Permission is hereby granted, Free of Cost, to any person obtaining a copy of this Font accompanying this license, the rights to Use, Copy, Distribute, subject to the following conditions:

1. The Font Software cannot be Sold, Modified, Altered, Translated, Reverse Engineered, Decompiled, Disassembled, Reproduced or Attempted to discover the Source Code of this Font in no means.

2. The Font Software is provided "AS IS", and KFGQPC makes no warranties as to its use or performance, fitness for a particular purpose. KFGQPC does not and cannot warrant the performance or results you may obtain by using the Font. In no event shall KFGQPC be liable for any Claims, Damages or other Liability, including any Damages, arising from, out of the use or inability to use the Font or from other dealings in the Font.

(النص أعلاه مستخرَج حرفياً من ملفَي الخط HafsSmart_08.ttf وUthmanTNB_v2-0.ttf المضمَّنين في التطبيق.)
''';

const String _silOfl = '''
Copyright (c) 1994-2026, SIL Global (https://www.sil.org/), with Reserved Font Names "Scheherazade" and "SIL".
Copyright 2010-2022 The Amiri Project Authors (https://github.com/aliftype/amiri).
Copyright 2022 The Noto Project Authors (https://github.com/notofonts/).

This Font Software is licensed under the SIL Open Font License, Version 1.1. This license is copied below, and is also available with a FAQ at: https://openfontlicense.org/

SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007

PREAMBLE
The goals of the Open Font License (OFL) are to stimulate worldwide development of collaborative font projects, to support the font creation efforts of academic and linguistic communities, and to provide a free and open framework in which fonts may be shared and improved in partnership with others.

The OFL allows the licensed fonts to be used, studied, modified and redistributed freely as long as they are not sold by themselves. The fonts, including any derivative works, can be bundled, embedded, redistributed and/or sold with any software provided that any reserved names are not used by derivative works. The fonts and derivatives, however, cannot be released under any other type of license. The requirement for fonts to remain under this license does not apply to any document created using the fonts or their derivatives.

DEFINITIONS
"Font Software" refers to the set of files released by the Copyright Holder(s) under this license and clearly marked as such. This may include source files, build scripts and documentation.

"Reserved Font Name" refers to any names specified as such after the copyright statement(s).

"Original Version" refers to the collection of Font Software components as distributed by the Copyright Holder(s).

"Modified Version" refers to any derivative made by adding to, deleting, or substituting -- in part or in whole -- any of the components of the Original Version, by changing formats or by porting the Font Software to a new environment.

"Author" refers to any designer, engineer, programmer, technical writer or other person who contributed to the Font Software.

PERMISSION & CONDITIONS
Permission is hereby granted, free of charge, to any person obtaining a copy of the Font Software, to use, study, copy, merge, embed, modify, redistribute, and sell modified and unmodified copies of the Font Software, subject to the following conditions:

1) Neither the Font Software nor any of its individual components, in Original or Modified Versions, may be sold by itself.

2) Original or Modified Versions of the Font Software may be bundled, redistributed and/or sold with any software, provided that each copy contains the above copyright notice and this license. These can be included either as stand-alone text files, human-readable headers or in the appropriate machine-readable metadata fields within text or binary files as long as those fields can be easily viewed by the user.

3) No Modified Version of the Font Software may use the Reserved Font Name(s) unless explicit written permission is granted by the corresponding Copyright Holder. This restriction only applies to the primary font name as presented to the users.

4) The name(s) of the Copyright Holder(s) or the Author(s) of the Font Software shall not be used to promote, endorse or advertise any Modified Version, except to acknowledge the contribution(s) of the Copyright Holder(s) and the Author(s) or with their explicit written permission.

5) The Font Software, modified or unmodified, in part or in whole, must be distributed entirely under this license, and must not be distributed under any other license. The requirement for fonts to remain under this license does not apply to any document created using the Font Software.

TERMINATION
This license becomes null and void if any of the above conditions are not met.

DISCLAIMER
THE FONT SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF COPYRIGHT, PATENT, TRADEMARK, OR OTHER RIGHT. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, INCLUDING ANY GENERAL, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF THE USE OR INABILITY TO USE THE FONT SOFTWARE OR FROM OTHER DEALINGS IN THE FONT SOFTWARE.

(النص أعلاه مستخرَج حرفياً من ملفات الخطوط QuranFont.ttf وAmiri-Bold.ttf وNotoSans-Regular.ttf وNotoSansArabic-Regular.ttf المضمَّنة في التطبيق. ملاحظة: QuranFont.ttf هو فعلياً خط "Scheherazade New" باسم مضلَّل داخل مشروع سراج — راجع TD-08 في docs/05_TECH_DEBT.md.)
''';
