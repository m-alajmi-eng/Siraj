import 'dart:io';
import '../../../../core/locale/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/mode/app_mode.dart';
import '../../../../core/mode/app_mode_provider.dart';
import '../../../../core/notifications/adhan_service.dart';

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

  final _madhabs = [
    {'id': 'hanafi',  'name': 'الحنفي'},
    {'id': 'maliki',  'name': 'المالكي'},
    {'id': 'shafi',   'name': 'الشافعي'},
    {'id': 'hanbali', 'name': 'الحنبلي'},
  ];

  final _calcMethods = [
    {'id': 'MWL',    'name': 'رابطة العالم الإسلامي'},
    {'id': 'ISNA',   'name': 'أمريكا الشمالية (ISNA)'},
    {'id': 'Egypt',  'name': 'الهيئة المصرية'},
    {'id': 'Makkah', 'name': 'أم القرى (مكة)'},
    {'id': 'Kuwait', 'name': 'الكويت'},
    {'id': 'Qatar',  'name': 'قطر'},
    {'id': 'Dubai',  'name': 'دبي'},
  ];

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
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'ha', 'name': 'Hausa', 'flag': '🇳🇬'},
    {'code': 'sw', 'name': 'Kiswahili', 'flag': '🇰🇪'},
    {'code': 'zh', 'name': '中文', 'flag': '🇨'},
  ];

  @override
  void initState() {
    super.initState();
    _box             = Hive.box('settings');
    _selectedAdhan   = _box.get('adhan_sound',  defaultValue: 'مكي (الحرم المكي)');
    _adhanEnabled    = _box.get('adhan_enabled', defaultValue: true);
    _vibrationEnabled = _box.get('vibration',   defaultValue: false);
    _iqamaAlert      = _box.get('iqama_alert',  defaultValue: 10);
    _madhab          = _box.get('madhab',        defaultValue: 'shafi');
    _calcMethod      = _box.get('calc_method',   defaultValue: 'MWL');
    _quranFont       = _box.get('quran_font',    defaultValue: 'uthmani');
    _fontSize        = _box.get('font_size',     defaultValue: 20.0);
    _locale          = _box.get('locale',        defaultValue: 'ar');
  }

  void _save(String key, dynamic value) {
    _box.put(key, value);
  }

  Future<void> _previewAdhan(String name) async {
    final url = AdhanService.adhanSounds[name];
    if (url != null) await AdhanService.playAdhan(url);
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(timeThemeProvider);
    final mode    = ref.watch(appModeProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                      color: palette.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'الإعدادات',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [

                  // ── الهوية ──────────────────────────────
                  _SectionHeader(title: 'الهوية', palette: palette),

                  _SettingsTile(
                    icon:    Icons.language,
                    title:   'اللغة',
                    value:   _locales.firstWhere(
                      (l) => l['code'] == _locale,
                      orElse: () => _locales[0],
                    )['name']!,
                    palette: palette,
                    onTap: () => _showOptions(
                      context:  context,
                      palette:  palette,
                      title:    'اختر اللغة',
                      options:  _locales.map((l) =>
                        '${l['flag']} ${l['name']}').toList(),
                      selected: _locales.firstWhere(
                        (l) => l['code'] == _locale)['name']!,
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
                    icon:    Icons.mosque,
                    title:   'المذهب',
                    value:   _madhabs.firstWhere(
                      (m) => m['id'] == _madhab)['name']!,
                    palette: palette,
                    onTap: () => _showOptions(
                      context:  context,
                      palette:  palette,
                      title:    'اختر المذهب',
                      options:  _madhabs.map((m) => m['name']!).toList(),
                      selected: _madhabs.firstWhere(
                        (m) => m['id'] == _madhab)['name']!,
                      onSelect: (val) {
                        final m = _madhabs.firstWhere(
                          (m) => m['name'] == val);
                        setState(() => _madhab = m['id']!);
                        _save('madhab', m['id']);
                      },
                    ),
                  ),

                  _SettingsTile(
                    icon:    Icons.calculate,
                    title:   'طريقة حساب الصلاة',
                    value:   _calcMethods.firstWhere(
                      (m) => m['id'] == _calcMethod)['name']!,
                    palette: palette,
                    onTap: () => _showOptions(
                      context:  context,
                      palette:  palette,
                      title:    'طريقة الحساب',
                      options:  _calcMethods.map(
                        (m) => m['name']!).toList(),
                      selected: _calcMethods.firstWhere(
                        (m) => m['id'] == _calcMethod)['name']!,
                      onSelect: (val) {
                        final m = _calcMethods.firstWhere(
                          (m) => m['name'] == val);
                        setState(() => _calcMethod = m['id']!);
                        _save('calc_method', m['id']);
                      },
                    ),
                  ),

                  // ── الأذان ──────────────────────────────
                  _SectionHeader(title: 'الأذان', palette: palette),

                  _SettingsSwitch(
                    icon:    Icons.volume_up,
                    title:   'تفعيل الأذان',
                    value:   _adhanEnabled,
                    palette: palette,
                    onChanged: (val) {
                      setState(() => _adhanEnabled = val);
                      _save('adhan_enabled', val);
                    },
                  ),

                  // اختيار المؤذن مع معاينة
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:        palette.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.mic,
                              color: palette.accentPrimary, size: 20),
                            Text(
                              'صوت المؤذن',
                              style: TextStyle(
                                color:   palette.textPrimary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...AdhanService.adhanSounds.keys.map((name) {
                          final isSelected = _selectedAdhan == name;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedAdhan = name);
                              _save('adhan_sound', name);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? palette.accentPrimary
                                        .withOpacity(0.15)
                                    : palette.background,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected
                                      ? palette.accentPrimary
                                      : Colors.transparent,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // زر المعاينة
                                  GestureDetector(
                                    onTap: () => _previewAdhan(name),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: palette.accentPrimary
                                            .withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color:  palette.accentPrimary,
                                        size:   16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    name,
                                    style: TextStyle(
                                      color: isSelected
                                          ? palette.accentPrimary
                                          : palette.textPrimary,
                                      fontSize: 14,
                                    ),
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
                    icon:    Icons.vibration,
                    title:   'اهتزاز بدل صوت',
                    value:   _vibrationEnabled,
                    palette: palette,
                    onChanged: (val) {
                      setState(() => _vibrationEnabled = val);
                      _save('vibration', val);
                    },
                  ),

                  // تنبيه قبل الإقامة
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:        palette.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'تنبيه قبل الإقامة',
                          style: TextStyle(
                            color:    palette.textPrimary,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                          children: [5, 10, 15, 20].map((min) {
                            final isSelected = _iqamaAlert == min;
                            return GestureDetector(
                              onTap: () {
                                setState(() => _iqamaAlert = min);
                                _save('iqama_alert', min);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? palette.accentPrimary
                                      : palette.background,
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '$min د',
                                  style: TextStyle(
                                    color: isSelected
                                        ? palette.background
                                        : palette.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // ── التطبيق ─────────────────────────────
                  _SectionHeader(title: 'التطبيق', palette: palette),

                  // وضع التطبيق
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:        palette.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Switch(
                          value: mode == AppMode.full,
                          onChanged: (_) => ref
                              .read(appModeProvider.notifier)
                              .toggle(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              mode == AppMode.full
                                  ? 'الوضع الكامل'
                                  : 'الوضع الخفيف',
                              style: TextStyle(
                                color:      palette.textPrimary,
                                fontSize:   15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              mode == AppMode.full
                                  ? 'كل الميزات متاحة'
                                  : 'الأساسيات فقط — offline',
                              style: TextStyle(
                                color:    palette.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  _SettingsTile(
                    icon:    Icons.menu_book,
                    title:   'خط القرآن',
                    value:   _quranFont == 'uthmani'
                        ? 'عثماني' : 'حفص',
                    palette: palette,
                    onTap: () => _showOptions(
                      context:  context,
                      palette:  palette,
                      title:    'خط القرآن',
                      options:  ['عثماني', 'حفص'],
                      selected: _quranFont == 'uthmani'
                          ? 'عثماني' : 'حفص',
                      onSelect: (val) {
                        final f = val == 'عثماني'
                            ? 'uthmani' : 'hafs';
                        setState(() => _quranFont = f);
                        _save('quran_font', f);
                      },
                    ),
                  ),

                  // حجم الخط
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:        palette.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'حجم خط القرآن',
                          style: TextStyle(
                            color:    palette.textPrimary,
                            fontSize: 15,
                          ),
                        ),
                        Slider(
                          value:    _fontSize,
                          min:      16,
                          max:      32,
                          divisions: 8,
                          label:    _fontSize.round().toString(),
                          activeColor: palette.accentPrimary,
                          onChanged: (val) {
                            setState(() => _fontSize = val);
                            _save('font_size', val);
                          },
                        ),
                        Center(
                          child: Text(
                            'بِسْمِ اللَّهِ',
                            style: TextStyle(
                              fontFamily: 'QuranFont',
                              color:      palette.textPrimary,
                              fontSize:   _fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── الخصوصية ────────────────────────────
                  _SectionHeader(
                    title: 'الخصوصية', palette: palette),

                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:        palette.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.lock,
                          color: palette.accentPrimary, size: 20),
                        Text(
                          'موقعك يبقى على جهازك فقط',
                          style: TextStyle(
                            color:    palette.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _SettingsTile(
                    icon:    Icons.delete_outline,
                    title:   'حذف بيانات الكاش',
                    value:   '',
                    palette: palette,
                    onTap: () => _confirmClearCache(
                      context, palette),
                  ),

                  // ── عن التطبيق ───────────────────────────
                  _SectionHeader(
                    title: 'عن التطبيق', palette: palette),

                  _SettingsTile(
                    icon:    Icons.info_outline,
                    title:   'الإصدار',
                    value:   '1.0.0',
                    palette: palette,
                    onTap:   () {},
                  ),

                  _SettingsTile(
                    icon:    Icons.share,
                    title:   'مشاركة التطبيق',
                    value:   '',
                    palette: palette,
                    onTap:   () {},
                  ),

                  const SizedBox(height: 32),

                  Center(
                    child: Text(
                      'سراج — نور على نور',
                      style: TextStyle(
                        color:    palette.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptions({
    required BuildContext       context,
    required dynamic            palette,
    required String             title,
    required List<String>       options,
    required String             selected,
    required Function(String)   onSelect,
  }) {
    showModalBottomSheet(
      context:            context,
      backgroundColor:    palette.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20))),
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color:        palette.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color:      palette.textPrimary,
                fontSize:   16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (_, i) {
                  final isSelected = options[i] == selected;
                  return ListTile(
                    title: Text(
                      options[i],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: isSelected
                            ? palette.accentPrimary
                            : palette.textPrimary,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check,
                            color: palette.accentPrimary)
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

  void _confirmClearCache(BuildContext context, dynamic palette) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: palette.surface,
        title: Text(
          'حذف الكاش',
          textAlign: TextAlign.right,
          style: TextStyle(color: palette.textPrimary),
        ),
        content: Text(
          'سيتم حذف البيانات المحفوظة محلياً. هل أنت متأكد؟',
          textAlign: TextAlign.right,
          style: TextStyle(color: palette.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء',
              style: TextStyle(color: palette.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Hive.box('quran_cache').clear();
              Hive.box('hadith_cache').clear();
              Navigator.pop(context);
            },
            child: Text('حذف',
              style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String  title;
  final dynamic palette;
  const _SectionHeader({required this.title, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          color:    palette.accentPrimary,
          fontSize: 13,
        ),
      ),
    );
  }
}

// ─── Settings Tile ────────────────────────────────────────
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String   title;
  final String   value;
  final dynamic  palette;
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
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color:        palette.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (value.isNotEmpty)
                  Text(
                    value,
                    style: TextStyle(
                      color:    palette.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_left,
                  color: palette.textSecondary, size: 18),
              ],
            ),
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color:    palette.textPrimary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(icon,
                  color: palette.accentPrimary, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Settings Switch ──────────────────────────────────────
class _SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final String   title;
  final bool     value;
  final dynamic  palette;
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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:        palette.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Switch(
            value:     value,
            onChanged: onChanged,
          ),
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color:    palette.textPrimary,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 12),
              Icon(icon,
                color: palette.accentPrimary, size: 20),
            ],
          ),
        ],
      ),
    );
  }
} 