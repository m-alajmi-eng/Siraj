import 'package:flutter/material.dart';

class ShareCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String content;
  final Color  backgroundColor;
  final Color  accentColor;
  final String type;
  final double width;
  final double height;

  const ShareCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.backgroundColor,
    required this.accentColor,
    required this.type,
    required this.width,
    required this.height,
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
      width:  width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin:  Alignment.topRight,
          end:    Alignment.bottomLeft,
          colors: [
            backgroundColor,
            backgroundColor.withValues(alpha: 0.9),
            accentColor.withValues(alpha: 0.25),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              top: -30, right: -30,
              child: Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withValues(alpha: 0.07),
                ),
              ),
            ),
            Positioned(
              bottom: -20, left: -20,
              child: Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withValues(alpha: 0.05),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(_typeIcon,
                            style: const TextStyle(fontSize: 14)),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Center(
                            child: Text(
                              content,
                              textAlign:     TextAlign.right,
                              textDirection: TextDirection.rtl,
                              overflow:      TextOverflow.fade,
                              style: TextStyle(
                                color:      Colors.white,
                                fontSize:   type == 'quran' ? 15 : 14,
                                fontFamily: type == 'quran' ? 'QuranFont' : null,
                                height:     1.8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (subtitle.isNotEmpty) ...[
                              Text(subtitle,
                                style: TextStyle(
                                  color:    Colors.white.withValues(alpha: 0.5),
                                  fontSize: 9,
                                )),
                              const SizedBox(width: 5),
                              Container(
                                width: 1, height: 9,
                                color: Colors.white.withValues(alpha: 0.3)),
                              const SizedBox(width: 5),
                            ],
                            Text(
                              title,
                              style: TextStyle(
                                color:      accentColor.withValues(alpha: 0.9),
                                fontSize:   10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // ─── شريط SIRAJ.App السفلي ─────────────
                Container(
                  width:  double.infinity,
                  height: 28,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    border: Border(
                      top: BorderSide(
                        color: accentColor.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 4, height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'SIRAJ.App',
                        style: TextStyle(
                          color:         Colors.white,
                          fontSize:      10,
                          fontWeight:    FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 4, height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}