import 'package:flutter/material.dart';

class ShareCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String content;
  final Color  backgroundColor;
  final Color  accentColor;
  final String type; // quran / athkar / hadith / achievement

  const ShareCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.backgroundColor,
    required this.accentColor,
    required this.type,
  });

  String get _typeIcon {
    switch (type) {
      case 'quran':       return '📖';
      case 'athkar':      return '🤲';
      case 'hadith':      return '📚';
      case 'achievement': return '⭐';
      default:            return '✨';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  340,
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin:  Alignment.topRight,
          end:    Alignment.bottomLeft,
          colors: [
            backgroundColor,
            backgroundColor.withOpacity(0.85),
            accentColor.withOpacity(0.3),
          ],
        ),
      ),
      child: Stack(
        children: [

          // ─── خلفية دوائر زخرفية ───────────────────────
          Positioned(
            top:   -40,
            right: -40,
            child: Container(
              width:  160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left:   -30,
            child: Container(
              width:  120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withOpacity(0.06),
              ),
            ),
          ),

          // ─── المحتوى ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                // أيقونة النوع
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // شعار سراج
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color:        accentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'سراج',
                        style: TextStyle(
                          color:      accentColor,
                          fontSize:   12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      _typeIcon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),

                const Spacer(),

                // المحتوى الرئيسي
                Text(
                  content,
                  textAlign:     TextAlign.right,
                  textDirection: TextDirection.rtl,
                  maxLines:      5,
                  overflow:      TextOverflow.ellipsis,
                  style: TextStyle(
                    color:      Colors.white,
                    fontSize:   type == 'quran' ? 20 : 16,
                    fontFamily: type == 'quran' ? 'QuranFont' : null,
                    height:     1.8,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 16),

                // العنوان والمصدر
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color:      accentColor,
                    fontSize:   13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color:    Colors.white.withOpacity(0.6),
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}