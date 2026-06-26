import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════
// Citation Badge — شارة المصدر الموثّق
// تُستخدم في كل مكان يظهر فيه نص ديني
// ═══════════════════════════════════════════════════════════

class CitationBadge extends StatelessWidget {
  final String  scholar;
  final String  bookTitle;
  final String? volume;
  final String? page;
  final dynamic palette;
  final bool    compact; // نسخة مضغوطة للقوائم

  const CitationBadge({
    super.key,
    required this.scholar,
    required this.bookTitle,
    required this.palette,
    this.volume,
    this.page,
    this.compact = false,
  });

  // مصادر معروفة مع أيقوناتها
  static const _sourceIcons = {
    'tabari-ar':     '📜',
    'ibn-kathir-ar': '📖',
    'baghawi-ar':    '📗',
    'saadi-ar':      '📘',
    'muyassar-ar':   '🌙',
    'mukhtasar-ar':  '⭐',
    'mukhtasar-en':  '🌍',
    'mukhtasar-bn':  '🌏',
  };

  static String iconForSource(String sourceId) =>
      _sourceIcons[sourceId] ?? '📚';

  @override
  Widget build(BuildContext context) {
    if (compact) return _buildCompact();
    return _buildFull();
  }

  Widget _buildCompact() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color:        palette.accentPrimary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: palette.accentPrimary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified,
            size:  10,
            color: palette.accentPrimary),
          const SizedBox(width: 4),
          Text(
            scholar,
            style: TextStyle(
              color:    palette.accentPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFull() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:        palette.accentPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: palette.accentPrimary.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // الصف الأول: العالم + أيقونة موثّق
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.verified,
                    size:  14,
                    color: Colors.green.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'موثّق',
                    style: TextStyle(
                      color:    Colors.green.shade600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Text(
                scholar,
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // الكتاب
          Text(
            bookTitle,
            textAlign: TextAlign.right,
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 12,
            ),
          ),
          // الجزء والصفحة إن وُجدا
          if (volume != null || page != null) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (page != null)
                  Text(
                    'ص $page',
                    style: TextStyle(
                      color:    palette.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                if (volume != null && page != null)
                  Text(
                    ' · ',
                    style: TextStyle(
                      color: palette.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                if (volume != null)
                  Text(
                    'ج $volume',
                    style: TextStyle(
                      color:    palette.textSecondary,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Source Map ───────────────────────────────────────────
// خريطة ثابتة لمصادر التفسير
const Map<String, Map<String, String>> tafsirSourcesMap = {
  'tabari-ar': {
    'scholar':   'الطبري',
    'bookTitle': 'جامع البيان عن تأويل آي القرآن',
    'died':      '310هـ',
  },
  'ibn-kathir-ar': {
    'scholar':   'ابن كثير',
    'bookTitle': 'تفسير القرآن العظيم',
    'died':      '774هـ',
  },
  'baghawi-ar': {
    'scholar':   'البغوي',
    'bookTitle': 'معالم التنزيل',
    'died':      '510هـ',
  },
  'saadi-ar': {
    'scholar':   'السعدي',
    'bookTitle': 'تيسير الكريم الرحمن',
    'died':      '1376هـ',
  },
  'muyassar-ar': {
    'scholar':   'مجمع الملك فهد',
    'bookTitle': 'التفسير الميسر',
    'died':      '',
  },
  'mukhtasar-ar': {
    'scholar':   'مركز تفسير',
    'bookTitle': 'المختصر في التفسير',
    'died':      '',
  },
  'mukhtasar-en': {
    'scholar':   'Tafsir Center',
    'bookTitle': 'Concise Commentary',
    'died':      '',
  },
  'mukhtasar-bn': {
    'scholar':   'তাফসীর সেন্টার',
    'bookTitle': 'সংক্ষিপ্ত তাফসীর',
    'died':      '',
  },
};