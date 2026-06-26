import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/radio_provider.dart';

class RadioScreen extends ConsumerWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stations = ref.watch(filteredStationsProvider);
    final radioState = ref.watch(radioProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إذاعات سراج'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── شريط الفئات ──
          _buildCategorySelector(ref, selectedCategory),
          
          // ── عرض حالة التحميل أو الخطأ أعلى القائمة ──
          if (radioState.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(),
            ),
          if (radioState.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                radioState.error!,
                style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

          // ── قائمة المحطات ──
          Expanded(
            child: ListView.builder(
              itemCount: stations.length,
              itemBuilder: (context, index) {
                final station = stations[index];
                final isCurrent = radioState.currentStation?.id == station.id;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  leading: Text(station.flag, style: const TextStyle(fontSize: 32)),
                  title: Text(
                    station.nameAr, 
                    style: TextStyle(
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      color: isCurrent ? theme.colorScheme.primary : theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  subtitle: Text(
                    station.country,
                    style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.6)),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      (isCurrent && radioState.isPlaying)
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: isCurrent ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.5),
                      size: 38,
                    ),
                    onPressed: () => ref.read(radioProvider.notifier).play(station),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── بناء شريط التمرير الأفقي للفئات ──
  Widget _buildCategorySelector(WidgetRef ref, String selected) {
    final Map<String, String> categories = {
      'all': 'الكل',
      'quran_ar': 'قرآن',
      'quran_trans': 'تراجم لغات',
      'tafseer': 'تفسير وفتاوى',
      'adhkar': 'أذكار ورقية',
      'international': 'إذاعات دولية',
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Wrap(
        spacing: 10,
        children: categories.entries.map((entry) {
          final isSelected = selected == entry.key;
          return ChoiceChip(
            label: Text(entry.value),
            selected: isSelected,
            showCheckmark: false, // إخفاء علامة الصح لجعل التصميم أنظف
            onSelected: (_) => ref.read(selectedCategoryProvider.notifier).select(entry.key),
          );
        }).toList(),
      ),
    );
  }
}