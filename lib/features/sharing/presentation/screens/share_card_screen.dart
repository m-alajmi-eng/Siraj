import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;
import '../../../../core/theme/time_theme_provider.dart';
import '../widgets/share_card_widget.dart';

class ShareCardScreen extends ConsumerStatefulWidget {
  final String title;
  final String subtitle;
  final String content;
  final String type;

  const ShareCardScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.type,
  });

  @override
  ConsumerState<ShareCardScreen> createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends ConsumerState<ShareCardScreen> {
  final GlobalKey _cardKey = GlobalKey();
  int _selectedTheme  = 0;
  int _selectedFormat = 0;

  final List<Map<String, dynamic>> _themes = [
    {'name': 'السماء الليلية', 'bg': const Color(0xFF0D1B2A), 'accent': const Color(0xFF4A9EFF)},
    {'name': 'غروب الشمس',     'bg': const Color(0xFF1A0A2E), 'accent': const Color(0xFFFF6B6B)},
    {'name': 'الفجر',          'bg': const Color(0xFF0A1628), 'accent': const Color(0xFFFFD700)},
    {'name': 'الزمرد',         'bg': const Color(0xFF0A1F14), 'accent': const Color(0xFF4CAF50)},
    {'name': 'الذهبي',         'bg': const Color(0xFF1A1200), 'accent': const Color(0xFFFFB300)},
  ];

  final List<Map<String, dynamic>> _formats = [
    {'icon': FontAwesomeIcons.instagram, 'color': const Color(0xFFE1306C), 'label': 'إنستقرام',  'desc': '1:1',     'width': 320.0, 'height': 320.0},
    {'icon': FontAwesomeIcons.xTwitter,  'color': const Color(0xFF1DA1F2), 'label': 'تويتر',     'desc': '16:9',    'width': 380.0, 'height': 213.0},
    {'icon': FontAwesomeIcons.whatsapp,  'color': const Color(0xFF25D366), 'label': 'واتساب',    'desc': '9:16',    'width': 270.0, 'height': 480.0},
    {'icon': FontAwesomeIcons.tiktok,    'color': const Color(0xFF010101), 'label': 'تيكتوك',    'desc': '9:16',    'width': 270.0, 'height': 480.0},
    {'icon': FontAwesomeIcons.facebook,  'color': const Color(0xFF1877F2), 'label': 'فيسبوك',    'desc': '1:1',     'width': 320.0, 'height': 320.0},
    {'icon': FontAwesomeIcons.telegram,  'color': const Color(0xFF2CA5E0), 'label': 'تيليغرام',  'desc': 'أي نسبة', 'width': 320.0, 'height': 320.0},
  ];

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(timeThemeProvider);
    final theme   = _themes[_selectedTheme];
    final format  = _formats[_selectedFormat];

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: palette.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'بطاقة المشاركة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: RepaintBoundary(
                  key: _cardKey,
                  child: ShareCardWidget(
                    title:           widget.title,
                    subtitle:        widget.subtitle,
                    content:         widget.content,
                    backgroundColor: theme['bg']    as Color,
                    accentColor:     theme['accent'] as Color,
                    type:            widget.type,
                    width:           format['width']  as double,
                    height:          format['height'] as double,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 72,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _formats.length,
                itemBuilder: (_, i) {
                  final f          = _formats[i];
                  final isSelected = _selectedFormat == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFormat = i),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (f['color'] as Color).withValues(alpha: 0.15)
                            : palette.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? (f['color'] as Color)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            f['icon'] as FaIconData,
                            color: isSelected
                                ? (f['color'] as Color)
                                : palette.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            f['desc'] as String,
                            style: TextStyle(
                              color:    palette.textSecondary,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _themes.length,
                itemBuilder: (_, i) {
                  final t          = _themes[i];
                  final isSelected = _selectedTheme == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTheme = i),
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (t['accent'] as Color)
                            : palette.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? (t['accent'] as Color)
                              : palette.accentPrimary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        t['name'] as String,
                        style: TextStyle(
                          color: isSelected ? Colors.white : palette.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.content));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('تم نسخ النص'),
                            backgroundColor: palette.accentPrimary,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color:        palette.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.copy, color: palette.textSecondary, size: 18),
                            const SizedBox(width: 8),
                            Text('نسخ النص',
                              style: TextStyle(color: palette.textSecondary, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => _shareCard(context, palette),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color:        palette.accentPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share, color: palette.background, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'مشاركة البطاقة',
                              style: TextStyle(
                                color:      palette.background,
                                fontSize:   15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareCard(BuildContext context, dynamic palette) async {
    try {
      final boundary = _cardKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image    = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('المشاركة متاحة على Android و iOS'),
            backgroundColor: palette.accentPrimary,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّرت المشاركة')),
      );
    }
  }
}