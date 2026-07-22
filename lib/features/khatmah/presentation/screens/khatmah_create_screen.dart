import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/khatmah_provider.dart';
import '../../domain/entities/khatmah_plan.dart';

class KhatmahCreateScreen extends ConsumerStatefulWidget {
  const KhatmahCreateScreen({super.key});

  @override
  ConsumerState<KhatmahCreateScreen> createState() => _KhatmahCreateScreenState();
}

class _KhatmahCreateScreenState extends ConsumerState<KhatmahCreateScreen> {
  final _nameController = TextEditingController();
  int _totalDays = 30;
  TimeOfDay? _reminderTime;

  static const int _totalMushafPages = 604;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  int get _dailyPortion => (_totalMushafPages / _totalDays).ceil();

  void _applyPreset(String name, int days) {
    setState(() {
      _totalDays = days;
      if (_nameController.text.isEmpty) _nameController.text = name;
    });
  }

  Future<void> _create() async {
    final t = AppLocalizations.of(context);
    final name = _nameController.text.trim().isEmpty
        ? t.khatmah_title
        : _nameController.text.trim();
    final now = DateTime.now();
    final plan = KhatmahPlan(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      startDate: now,
      totalDays: _totalDays,
      currentPage: 0,
      createdAt: now,
      reminderTime: _reminderTime == null
          ? null
          : '${_reminderTime!.hour.toString().padLeft(2, '0')}:'
              '${_reminderTime!.minute.toString().padLeft(2, '0')}',
    );
    await ref.read(khatmahProvider.notifier).addPlan(plan);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    return AppScaffold(
      title: t.khatmah_new,
      padding: EdgeInsets.zero,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: const EdgeInsets.all(SirajLayout.pagePadding),
            children: [
              // خيارات جاهزة
              Wrap(
                spacing: SirajSpacing.s2,
                runSpacing: SirajSpacing.s2,
                children: [
                  _presetChip(t.khatmah_preset_ramadan, 30, palette),
                  _presetChip(t.khatmah_preset_weekly, 7, palette),
                  _presetChip(t.khatmah_preset_monthly, 30, palette),
                ],
              ),
              const SizedBox(height: SirajSpacing.s5),
              // اسم الختمة
              Text(t.khatmah_name,
                  style: AppText.caption.copyWith(color: palette.textSecondary)),
              const SizedBox(height: SirajSpacing.s2),
              TextField(
                controller: _nameController,
                style: AppText.body.copyWith(color: palette.textPrimary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: palette.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: SirajSpacing.s5),
              // المدة
              Text(t.khatmah_duration_days,
                  style: AppText.caption.copyWith(color: palette.textSecondary)),
              const SizedBox(height: SirajSpacing.s2),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _totalDays.toDouble(),
                      min: 3,
                      max: 365,
                      activeColor: palette.accentPrimary,
                      onChanged: (v) => setState(() => _totalDays = v.round()),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: Text('$_totalDays',
                        textAlign: TextAlign.center,
                        style: AppText.body.copyWith(color: palette.textPrimary)),
                  ),
                ],
              ),
              const SizedBox(height: SirajSpacing.s3),
              // ملخص الوِرد اليومي
              Container(
                padding: const EdgeInsets.all(SirajSpacing.s4),
                decoration: BoxDecoration(
                  color: palette.accentPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                ),
                child: Text(
                  '${t.khatmah_daily_pages}: $_dailyPortion',
                  style: AppText.body.copyWith(
                      color: palette.accentPrimary, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: SirajSpacing.s5),
              // وقت التذكير
              InkWell(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _reminderTime ?? const TimeOfDay(hour: 7, minute: 0),
                  );
                  if (picked != null) setState(() => _reminderTime = picked);
                },
                child: Container(
                  padding: const EdgeInsets.all(SirajSpacing.s4),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(t.khatmah_reminder_time,
                          style: AppText.body.copyWith(color: palette.textPrimary)),
                      Text(
                        _reminderTime == null
                            ? '—'
                            : _reminderTime!.format(context),
                        style: AppText.body.copyWith(color: palette.accentPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: SirajSpacing.s8),
              // زر الإنشاء
              ElevatedButton(
                onPressed: _create,
                style: ElevatedButton.styleFrom(
                  backgroundColor: palette.accentPrimary,
                  padding: const EdgeInsets.symmetric(vertical: SirajSpacing.s4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                  ),
                ),
                child: Text(t.khatmah_create,
                    style: AppText.body.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
      ),
    );
  }

  Widget _presetChip(String label, int days, SirajPalette palette) {
    final selected = _totalDays == days;
    return GestureDetector(
      onTap: () => _applyPreset(label, days),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: SirajSpacing.s3, vertical: SirajSpacing.s2),
        decoration: BoxDecoration(
          color: selected
              ? palette.accentPrimary.withValues(alpha: 0.15)
              : palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
          border: Border.all(
            color: selected ? palette.accentPrimary : Colors.transparent,
          ),
        ),
        child: Text(label,
            style: AppText.caption.copyWith(
                color: selected ? palette.accentPrimary : palette.textPrimary)),
      ),
    );
  }
}
