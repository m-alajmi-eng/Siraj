import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_library/quran_library.dart';
import '../../../khatmah/presentation/providers/khatmah_provider.dart';
import '../../../../core/storage/cache_service.dart';
import '../../../../l10n/app_localizations.dart';

/// وضع "المصحف المطبوع": تطابق حرفي لمصحف المدينة (604 صفحة) عبر
/// حزمة quran_library. شريط تنقّل مؤقت وبسيط (سيُستبدل بتصميم كامل
/// لاحقاً في مرحلة التصميم النهائية للمصحف).
class PageReaderScreen extends ConsumerStatefulWidget {
  final int initialPage;
  final String? khatmahId;

  const PageReaderScreen({super.key, this.initialPage = 1, this.khatmahId});

  @override
  ConsumerState<PageReaderScreen> createState() => _PageReaderScreenState();
}

class _PageReaderScreenState extends ConsumerState<PageReaderScreen> {
  static const int _totalPages = 604;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage.clamp(1, _totalPages);
  }

  void _goToPage(int page) {
    final target = page.clamp(1, _totalPages);
    setState(() => _currentPage = target);
    _recordKhatmahProgressIfNeeded(target);
    _saveUnifiedPosition(target);
  }

  /// إن كانت الشاشة مفتوحة ضمن سياق ختمة، نسجّل الصفحة الحالية
  /// كتقدّم فعلي (المرحلة 4 من KHATMAH_DESIGN.md).
  void _recordKhatmahProgressIfNeeded(int page) {
    final khatmahId = widget.khatmahId;
    if (khatmahId == null) return;
    ref.read(khatmahProvider.notifier).recordProgress(khatmahId, page);
  }

  /// يسجّل هذه الصفحة كموضع القراءة الموحّد الحالي (المرحلة 6):
  /// نوع السياق يعكس هل نحن ضمن ختمة أم تصفّح صفحات حر.
  void _saveUnifiedPosition(int page) {
    final khatmahId = widget.khatmahId;
    CacheService.saveLastReadingContext(
      type: khatmahId != null ? 'khatmah_page' : 'page',
      page: page,
      khatmahId: khatmahId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي مؤقت وبسيط: رجوع + رقم الصفحة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    tooltip: t.common_back,
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text('$_currentPage / $_totalPages',
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(width: 48), // موازنة زر الرجوع
                ],
              ),
            ),
            Expanded(
              child: QuranPagesScreen(
                parentContext: context,
                page: _currentPage,
                withPageView: false, // نتحكم نحن بالتنقّل مؤقتاً
                useDefaultAppBar: false,
                onPageChanged: (page) {
                  setState(() => _currentPage = page);
                  _recordKhatmahProgressIfNeeded(page);
                  _saveUnifiedPosition(page);
                },
              ),
            ),
            // شريط تنقّل مؤقت وبسيط: أزرار يمين/يسار
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    tooltip: t.common_prevPage,
                    onPressed:
                        _currentPage > 1 ? () => _goToPage(_currentPage - 1) : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    tooltip: t.common_nextPage,
                    onPressed: _currentPage < _totalPages
                        ? () => _goToPage(_currentPage + 1)
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
