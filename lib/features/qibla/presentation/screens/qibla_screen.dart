import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'dart:math' as math;
import '../../../../core/theme/time_theme_provider.dart';

class QiblaScreen extends ConsumerWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);

    // Linux لا يدعم البوصلة
    if (!Platform.isAndroid && !Platform.isIOS) {
      return Scaffold(
        backgroundColor: palette.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore,
                color: palette.textSecondary, size: 60),
              const SizedBox(height: 16),
              Text(
                'القبلة متاحة على الجوال فقط',
                style: TextStyle(
                  color:    palette.textSecondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Android / iOS',
                style: TextStyle(
                  color:    palette.accentPrimary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 16),
              child: Text(
                'اتجاه القبلة',
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   28,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            Expanded(
              child: StreamBuilder(
                stream: FlutterQiblah.qiblahStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: palette.accentPrimary),
                    );
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.compass_calibration,
                            color: palette.textSecondary, size: 60),
                          const SizedBox(height: 16),
                          Text(
                            'تعذّر تحديد اتجاه القبلة',
                            style: TextStyle(
                              color:    palette.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'تأكد من تفعيل البوصلة والموقع',
                            style: TextStyle(
                              color:    palette.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final qiblah = snapshot.data!;
                  final angle  = (qiblah.qiblah * (math.pi / 180)) * -1;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:  280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: palette.surface,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width:  260,
                              height: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: palette.accentPrimary
                                      .withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                            ),
                            Container(
                              width:  200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: palette.accentPrimary
                                      .withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                            ),
                            Transform.rotate(
                              angle: angle,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.navigation,
                                    color: palette.accentPrimary,
                                    size:  80,
                                  ),
                                  Text(
                                    'الكعبة',
                                    style: TextStyle(
                                      color:    palette.accentPrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width:  12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: palette.accentPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      Text(
                        '${qiblah.qiblah.toStringAsFixed(1)}°',
                        style: TextStyle(
                          color:      palette.textPrimary,
                          fontSize:   48,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'من الشمال باتجاه القبلة',
                        style: TextStyle(
                          color:    palette.textSecondary,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 32),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color:        palette.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width:  8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: palette.accentPrimary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'البوصلة نشطة',
                              style: TextStyle(
                                color:    palette.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 