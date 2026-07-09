import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qcf_quran/qcf_quran.dart';
import '../../../../core/theme/design_tokens.dart';

/// ألوان دافئة تحاكي ورق المصحف المطبوع (لا ألوان التطبيق الليلية/الزرقاء).
class _MushafColors {
  static const paper = Color(0xFFFBF6EC);
  static const ink = Color(0xFF1B1B1B);
  static const gold = Color(0xFF9C7A2D);
}

/// وضع "المصحف المطبوع": تطابق حرفي لمصحف المدينة (604 صفحة) عبر
/// حزمة qcf_quran (خطوط QCF الرسمية مضمّنة محلياً بالكامل - offline).
class PageReaderScreen extends ConsumerStatefulWidget {
  final int initialPage;
  final String? khatmahId;

  const PageReaderScreen({super.key, this.initialPage = 1, this.khatmahId});

  @override
  ConsumerState<PageReaderScreen> createState() => _PageReaderScreenState();
}

class _PageReaderScreenState extends ConsumerState<PageReaderScreen> {
  static const int _totalPages = 604;
  // قيمة ثابتة معقولة (لا حساب تلقائي من عرض الشاشة، تفادياً لتضخم
  // المسافات على الشاشات الكبيرة/التابلت). تُضبط يدوياً حسب الحاجة.
  static const double _scale = 1.0;

  late final PageController _controller;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage.clamp(1, _totalPages);
    _controller = PageController(initialPage: _currentPage - 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    final target = page.clamp(1, _totalPages);
    _controller.animateToPage(
      target - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _MushafColors.paper,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(SirajSpacing.s3),
                decoration: BoxDecoration(
                  border: Border.all(color: _MushafColors.gold, width: 2.5),
                  borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                ),
                clipBehavior: Clip.antiAlias,
                child: PageviewQuran(
                  controller: _controller,
                initialPageNumber: _currentPage,
                sp: _scale,
                h: _scale,
                onPageChanged: (page) => setState(() => _currentPage = page),
                theme: QcfThemeData(
                  pageBackgroundColor: _MushafColors.paper,
                  verseTextColor: _MushafColors.ink,
                  verseNumberColor: _MushafColors.gold,
                  basmalaColor: _MushafColors.gold,
                  headerTextColor: _MushafColors.gold,
                    headerBackgroundColor: _MushafColors.paper,
                  ),
                ),
              ),
            ),
            _buildNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s2, vertical: SirajSpacing.s2),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: _MushafColors.ink),
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s4, vertical: SirajSpacing.s3),
      decoration: BoxDecoration(
        color: _MushafColors.paper,
        border: Border(top: BorderSide(color: _MushafColors.gold.withValues(alpha: 0.3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_right, color: _MushafColors.gold),
            onPressed: _currentPage > 1 ? () => _goToPage(_currentPage - 1) : null,
          ),
          Text('$_currentPage / $_totalPages',
              style: const TextStyle(color: _MushafColors.ink, fontSize: 14)),
          IconButton(
            icon: const Icon(Icons.chevron_left, color: _MushafColors.gold),
            onPressed: _currentPage < _totalPages ? () => _goToPage(_currentPage + 1) : null,
          ),
        ],
      ),
    );
  }
}
