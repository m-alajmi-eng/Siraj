import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/athkar_provider.dart';
import 'athkar_category_screen.dart';

class AthkarHomeScreen extends ConsumerWidget {
  const AthkarHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette    = ref.watch(timeThemeProvider);
    final categories = ref.watch(athkarCategoriesProvider);

    final icons = {
      'morning': Icons.wb_sunny_outlined,
      'evening': Icons.nights_stay_outlined,
      'sleep':   Icons.bedtime_outlined,
      'wake':    Icons.alarm_outlined,
      'prayer':  Icons.mosque_outlined,
      'general': Icons.favorite_border,
    };

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الأذكار',
                style: TextStyle(
                  color: palette.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),

              categories.when(
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: palette.accentPrimary),
                ),
                error: (e, _) => Center(
                  child: Text('خطأ',
                    style: TextStyle(color: palette.textPrimary)),
                ),
                data: (cats) => Expanded(
                  child: GridView.builder(
                    gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:   2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing:  12,
                        childAspectRatio: 1.3,
                      ),
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      final cat = cats[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AthkarCategoryScreen(
                              categoryId:   cat.id,
                              categoryName: cat.name,
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:        palette.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icons[cat.id] ?? Icons.star_outline,
                                color: palette.accentPrimary,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                cat.name,
                                style: TextStyle(
                                  color:      palette.textPrimary,
                                  fontSize:   14,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                cat.time,
                                style: TextStyle(
                                  color:    palette.textSecondary,
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}