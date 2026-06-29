import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/mode/app_mode.dart';
import '../../../../core/mode/app_mode_provider.dart';
import '../../../../core/notifications/adhan_service.dart';
import '../../../../core/widgets/app_scaffold.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late Box _box;

  String _selectedAdhan    = 'مكي (الحرم المكي)';
  bool   _adhanEnabled     = true;
  bool   _vibrationEnabled = false;
  int    _iqamaAlert       = 10;
  String _madhab           = 'shafi';
  String _calcMethod       = 'MWL';
  String _quranFont        = 'uthmani';
  double _fontSize         = 20;
  String _locale           = 'ar';

  // البيانات: id فقط (تُترجم وقت العرض)
  final _madhabIds   = ['hanafi', 'maliki', 'shafi', 'hanbali'];
  final _calcIds     = ['MWL', 'ISNA', 'Egypt', 'Makkah', 'Kuwait', 'Qatar', 'Dubai'];

  final _locales = [
    {'code': 'ar', 'name': 'العربية',   'flag': '🇸🇦'},
    {'code': 'en', 'name': 'English',   'flag': '🇬🇧'},
    {'code': 'id', 'name': 'Indonesia', 'flag': '🇮🇩'},
    {'code': 'ur', 'name': 'اردو',      'flag': '🇵🇰'},
    {'code': 'tr', 'name': 'Türkçe',    'flag': '🇹🇷'},
    {'code': 'fr', 'name': 'Français',  'flag': '🇫🇷'},
    {'code': 'bn', 'name': 'বাংলা',     'flag': '🇧🇩'},
    {'code': 'ms', 'name': 'Melayu',    'flag': '🇲🇾'},
    {'code': 'fa', 'name': 'فارسی',     'flag': '🇮🇷'},
    {'code': 'ru', 'name': 'Русский',   'flag': '🇷🇺'},
    {'code': 'de', 'name': 'Deutsch',   'flag': '🇩🇪'},
    {'code': 'es', 'name': 'Español',   'flag': '🇪🇸'},
    {'code': 'ha', 'name': 'Hausa',     'flag': '🇳🇬'},
    {'code': 'sw', 'name': 'Kiswahili', 'flag': '🇰🇪'},
    {'code': 'zh', 'name': '中文',       'flag': '🇨🇳'},
  ];

  String _madhabName(AppLocalizations t, String id) {
    switch (id) {
      case 'hanafi':  return t.madhab_hanafi;
      case 'maliki':  return t.madhab_maliki;
      case 'shafi':   return t.madhab_shafi;
      default:        return t.madhab_hanbali;
    }
  }

  String _calcName(AppLocalizations t, String id) {
    switch (id) {
      case 'MWL':    return t.calc_MWL;
      case 'ISNA':   return t.calc_ISNA;
      case 'Egypt':  return t.calc_Egypt;
      case 'Makkah': return t.calc_Makkah;
      case 'Kuwait': return t.calc_Kuwait;
      case 'Qatar':  return t.calc_Qatar;
      default:       return t.calc_Dubai;
    }
  }

  @override
  void initState() {
    super.initState();
    _box              = Hive.box('settings');
    _selectedAdhan    = _box.get('adhan_sound',   defaultValue: 'مكي (الحرم المكي)');
    _adhanEnabled     = _box.get('adhan_enabled', defaultValue: true);
    _vibrationEnabled = _box.get('vibration',     defaultValue: false);
    _iqamaAlert       = _box.get('iqama_alert',   defaultValue: 10);
    _madhab           = _box.get('madhab',        defaultValue: 'shafi');
    _calcMethod       = _box.get('calc_method',   defaultValue: 'MWL');
    _quranFont        = _box.get('quran_font',    defaultValue: 'uthmani');
    _fontSize         = _box.get('font_size',     defaultValue: 20.0);
    _locale           = _box.get('locale',        defaultValue: 'ar');
  }

  void _save(String key, dynamic value) => _box.put(key, value);

  Future<void> _previewAdhan(String name) async {
    final url = AdhanService.adhanSounds[name];
    if (url != null) await AdhanService.playAdhan(url);
  }

  @override
  Widget build(BuildContext context) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final mode    = ref.watch(appModeProvider);

    return AppScaffold(
      title: t.settings_title,
      padding: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
        children: [
          // ── الهوية ──
          _SectionHeader(title: t.settings_secIdentity, palette: palette),

          _SettingsTile(
            icon: Icons.language,
            title: t.settings_language,
            value: _locales.firstWhere(
              (l) => l['code'] == _locale,
              orElse: () => _locales[0],
            )['name']!,
            palette: palette,
            onTap: () => _showOptions(
              context: context,
              palette: palette,
              title: t.settings_chooseLanguage,
              options: _locales.map((l) => '${l['flag']} ${l['name']}').toList(),
              selected: _locales.firstWhere((l) => l['code'] == _locale)['name']!,
              onSelect: (val) {
                final l = _locales.firstWhere(
                  (l) => '${l['flag']} ${l['name']}' == val);
                setState(() => _locale = l['code']!);
                _save('locale', l['code']);
                ref.read(localeProvider.notifier).setLocale(l['code']!);
              },
            ),
          ),

          _SettingsTile(
            icon: Icons.mosque,
            title: t.settings_madhab,
            value: _madhabName(t, _madhab),
            palette: palette,
            onTap: () => _showOptions(
              context: context,
              palette: palette,
              title: t.settings_chooseMadhab,
              options: _madhabIds.map((id) => _madhabName(t, id)).toList(),
              selected: _madhabName(t, _madhab),
              onSelect: (val) {
                final id = _madhabIds.firstWhere((id) => _madhabName(t, id) == val);
                setState(() => _madhab = id);
                _save('madhab', id);
              },
            ),
          ),

          _SettingsTile(
            icon: Icons.calculate,
            title: t.settings_calcMethod,
            value: _calcName(t, _calcMethod),
            palette: palette,
            onTap: () => _showOptions(
              context: context,
              palette: palette,
              title: t.settings_chooseCalc,
              options: _calcIds.map((id) => _calcName(t, id)).toList(),
              selected: _calcName(t, _calcMethod),
              onSelect: (val) {
                final id = _calcIds.firstWhere((id) => _calcName(t, id) == val);
                setState(() => _calcMethod = id);
                _save('calc_method', id);
              },
            ),
          ),

          // ── الأذان ──
          _SectionHeader(title: t.settings_secAdhan, palette: palette),

          _SettingsSwitch(
            icon: Icons.volume_up,
            title: t.settings_enableAdhan,
            value: _adhanEnabled,
            palette: palette,
            onChanged: (val) {
              setState(() => _adhanEnabled = val);
              _save('adhan_enabled', val);
            },
          ),

          // صوت المؤذن (أسماء المؤذنين تبقى عربية — محتوى)
          Container(
            margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
            padding: const EdgeInsets.all(SirajSpacing.s4),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.mic, color: palette.accentPrimary, size: 20),
                    const SizedBox(width: SirajSpacing.s2),
                    Text(t.settings_muezzinVoice, style: AppText.body.copyWith(
                      color: palette.textPrimary)),
                  ],
                ),
                const SizedBox(height: SirajSpacing.s3),
                ...AdhanService.adhanSounds.keys.map((name) {
                  final isSelected = _selectedAdhan == name;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedAdhan = name);
                      _save('adhan_sound', name);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: SirajSpacing.s3, vertical: SirajSpacing.s2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? palette.accentPrimary.withValues(alpha: 0.15)
                            : palette.background,
                        borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                        border: Border.all(
                          color: isSelected ? palette.accentPrimary : Colors.transparent),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => _previewAdhan(name),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: palette.accentPrimary.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.play_arrow,
                                color: palette.accentPrimary, size: 16),
                            ),
                          ),
                          Expanded(
                            child: Text(name, textAlign: TextAlign.end,
                              style: AppText.bodySmall.copyWith(
                                color: isSelected
                                    ? palette.accentPrimary : palette.textPrimary)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          _SettingsSwitch(
            icon: Icons.vibration,
            title: t.settings_vibration,
            value: _vibrationEnabled,
            palette: palette,
            onChanged: (val) {
              setState(() => _vibrationEnabled = val);
              _save('vibration', val);
            },
          ),

          // تنبيه قبل الإقامة
          Container(
            margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
            padding: const EdgeInsets.all(SirajSpacing.s4),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.settings_iqamaAlert, style: AppText.body.copyWith(
                  color: palette.textPrimary)),
                const SizedBox(height: SirajSpacing.s3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [5, 10, 15, 20].map((min) {
                    final isSelected = _iqamaAlert == min;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _iqamaAlert = min);
                        _save('iqama_alert', min);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
                        decoration: BoxDecoration(
                          color: isSelected ? palette.accentPrimary : palette.background,
                          borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
                        ),
                        child: Text(t.settings_minutes(min), style: AppText.bodySmall.copyWith(
                          color: isSelected ? palette.background : palette.textSecondary)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // ── التطبيق ──
          _SectionHeader(title: t.settings_secApp, palette: palette),

          Container(
            margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
            padding: const EdgeInsets.all(SirajSpacing.s4),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.md),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: mode == AppMode.full,
                  onChanged: (_) => ref.read(appModeProvider.notifier).toggle(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        mode == AppMode.full ? t.settings_fullMode : t.settings_liteMode,
                        style: AppText.body.copyWith(
                          color: palette.textPrimary, fontWeight: FontWeight.w500)),
                      Text(
                        mode == AppMode.full
                            ? t.settings_fullModeDesc : t.settings_liteModeDesc,
                        style: AppText.caption.copyWith(color: palette.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          _SettingsTile(
            icon: Icons.menu_book,
            title: t.settings_quranFont,
            value: _quranFont == 'uthmani' ? t.settings_fontUthmani : t.settings_fontHafs,
            palette: palette,
            onTap: () => _showOptions(
              context: context,
              palette: palette,
              title: t.settings_quranFont,
              options: [t.settings_fontUthmani, t.settings_fontHafs],
              selected: _quranFont == 'uthmani' ? t.settings_fontUthmani : t.settings_fontHafs,
              onSelect: (val) {
                final f = val == t.settings_fontUthmani ? 'uthmani' : 'hafs';
                setState(() => _quranFont = f);
                _save('quran_font', f);
              },
            ),
          ),

          // حجم الخط
          Container(
            margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
            padding: const EdgeInsets.all(SirajSpacing.s4),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.settings_quranFontSize, style: AppText.body.copyWith(
                  color: palette.textPrimary)),
                Slider(
                  value: _fontSize,
                  min: 16, max: 32, divisions: 8,
                  label: _fontSize.round().toString(),
                  activeColor: palette.accentPrimary,
                  onChanged: (val) {
                    setState(() => _fontSize = val);
                    _save('font_size', val);
                  },
                ),
                Center(
                  child: Text('بِسْمِ اللَّهِ',
                    style: TextStyle(
                      fontFamily: 'QuranFont',
                      color: palette.textPrimary,
                      fontSize: _fontSize)),
                ),
              ],
            ),
          ),

          // ── الخصوصية ──
          _SectionHeader(title: t.settings_secPrivacy, palette: palette),

          Container(
            margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
            padding: const EdgeInsets.all(SirajSpacing.s4),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.md),
            ),
            child: Row(
              children: [
                Icon(Icons.lock, color: palette.accentPrimary, size: 20),
                const SizedBox(width: SirajSpacing.s2),
                Expanded(
                  child: Text(t.settings_privacyNote, style: AppText.caption.copyWith(
                    color: palette.textSecondary)),
                ),
              ],
            ),
          ),

          _SettingsTile(
            icon: Icons.delete_outline,
            title: t.settings_clearCache,
            value: '',
            palette: palette,
            onTap: () => _confirmClearCache(context, palette, t),
          ),

          // ── عن التطبيق ──
          _SectionHeader(title: t.settings_secAbout, palette: palette),

          _SettingsTile(
            icon: Icons.info_outline,
            title: t.settings_version,
            value: '1.0.0',
            palette: palette,
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.share,
            title: t.settings_shareApp,
            value: '',
            palette: palette,
            onTap: () {},
          ),

          const SizedBox(height: SirajSpacing.s8),
          Center(
            child: Text(t.settings_tagline, style: AppText.caption.copyWith(
              color: palette.textSecondary)),
          ),
          const SizedBox(height: SirajSpacing.s8),
        ],
      ),
    );
  }

  void _showOptions({
    required BuildContext context,
    required dynamic palette,
    required String title,
    required List<String> options,
    required String selected,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(SirajRadiusFull.xl))),
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            const SizedBox(height: SirajSpacing.s3),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: palette.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: SirajSpacing.s4),
            Text(title, style: AppText.headline.copyWith(color: palette.textPrimary)),
            const SizedBox(height: SirajSpacing.s2),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (_, i) {
                  final isSelected = options[i] == selected;
                  return ListTile(
                    title: Text(options[i],
                      style: AppText.body.copyWith(
                        color: isSelected ? palette.accentPrimary : palette.textPrimary)),
                    trailing: isSelected
                        ? Icon(Icons.check, color: palette.accentPrimary)
                        : null,
                    onTap: () {
                      onSelect(options[i]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmClearCache(BuildContext context, dynamic palette, AppLocalizations t) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: palette.surface,
        title: Text(t.settings_clearCacheTitle, style: AppText.headline.copyWith(
          color: palette.textPrimary)),
        content: Text(t.settings_clearCacheMsg, style: AppText.body.copyWith(
          color: palette.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.settings_cancel, style: TextStyle(color: palette.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Hive.box('quran_cache').clear();
              Hive.box('hadith_cache').clear();
              Navigator.pop(context);
            },
            child: Text(t.settings_delete, style: const TextStyle(color: Color(0xFFE57373))),
          ),
        ],
      ),
    );
  }
}

// ─── Section Header ───
class _SectionHeader extends StatelessWidget {
  final String title;
  final dynamic palette;
  const _SectionHeader({required this.title, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SirajSpacing.s5, bottom: SirajSpacing.s2),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(title, style: AppText.bodySmall.copyWith(color: palette.accentPrimary)),
      ),
    );
  }
}

// ─── Settings Tile ───
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final dynamic palette;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          children: [
            Icon(icon, color: palette.accentPrimary, size: 20),
            const SizedBox(width: SirajSpacing.s3),
            Expanded(
              child: Text(title, style: AppText.body.copyWith(color: palette.textPrimary)),
            ),
            if (value.isNotEmpty)
              Text(value, style: AppText.bodySmall.copyWith(color: palette.textSecondary)),
            const SizedBox(width: SirajSpacing.s2),
            Icon(Icons.chevron_right, color: palette.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}

// ─── Settings Switch ───
class _SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final dynamic palette;
  final Function(bool) onChanged;

  const _SettingsSwitch({
    required this.icon,
    required this.title,
    required this.value,
    required this.palette,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
      padding: const EdgeInsets.symmetric(
        horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(SirajRadiusFull.md),
      ),
      child: Row(
        children: [
          Icon(icon, color: palette.accentPrimary, size: 20),
          const SizedBox(width: SirajSpacing.s3),
          Expanded(
            child: Text(title, style: AppText.body.copyWith(color: palette.textPrimary)),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}