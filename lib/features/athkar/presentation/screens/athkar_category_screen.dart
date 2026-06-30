import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/athkar_provider.dart';

class AthkarCategoryScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String categoryName;

  const AthkarCategoryScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  ConsumerState<AthkarCategoryScreen> createState() =>
      _AthkarCategoryScreenState();
}

class _AthkarCategoryScreenState
    extends ConsumerState<AthkarCategoryScreen> {
  int  _currentIndex = 0;
  int  _currentCount = 0;
  bool _completed    = false;
  bool _allDone      = false;
  bool _showList     = false;

  String _catName(AppLocalizations t) {
    switch (widget.categoryId) {
      case 'morning': return t.athkar_morning;
      case 'evening': return t.athkar_evening;
      case 'sleep':   return t.athkar_sleep;
      case 'wake':    return t.athkar_wake;
      case 'prayer':  return t.athkar_prayer;
      case 'general': return t.athkar_general;
      default:        return widget.categoryName;
    }
  }

  void _increment(int target, int total) {
    HapticFeedback.lightImpact();
    setState(() {
      _currentCount++;
      if (_currentCount >= target) {
        _completed = true;
        HapticFeedback.mediumImpact();
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) _next(total);
        });
      }
    });
  }

  void _next(int total) {
    if (_currentIndex < total - 1) {
      setState(() {
        _currentIndex++;
        _currentCount = 0;
        _completed    = false;
      });
    } else {
      setState(() => _allDone = true);
    }
  }

  void _prev() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _currentCount = 0;
        _completed    = false;
      });
    }
  }

  void _jumpTo(int index) {
    setState(() {
      _currentIndex = index;
      _currentCount = 0;
      _completed    = false;
      _showList     = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t           = AppLocalizations.of(context);
    final palette     = ref.watch(timeThemeProvider);
    final athkarAsync = ref.watch(
      athkarByCategoryProvider(widget.categoryId));

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: athkarAsync.when(
          loading: () => Center(
            child: CircularProgressIndicator(
              color: palette.accentPrimary)),
          error: (e, _) => Center(
            child: Text(t.athkarcat_error,
              style: TextStyle(color: palette.textPrimary))),
          data: (athkar) {
            if (athkar.isEmpty) {
              return Center(
                child: Text(t.athkarcat_empty,
                  style: TextStyle(color: palette.textPrimary)));
            }

            if (_allDone) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle,
                      color: palette.accentPrimary, size: 80),
                    const SizedBox(height: 20),
                    Text(
                      t.athkarcat_completed(_catName(t)),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                        decoration: BoxDecoration(
                          color:        palette.accentPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          t.athkarcat_back,
                          style: TextStyle(
                            color:    palette.surface,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            final current  = athkar[_currentIndex];
            final progress = _currentCount / current.count;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,
                          color: palette.textPrimary),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          _catName(t),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:      palette.textPrimary,
                            fontSize:   18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            setState(() => _showList = !_showList),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _showList
                                ? palette.accentPrimary
                                : palette.accentPrimary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.list,
                                color: _showList
                                    ? palette.surface
                                    : palette.accentPrimary,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${_currentIndex + 1}/${athkar.length}',
                                style: TextStyle(
                                  color: _showList
                                      ? palette.surface
                                      : palette.accentPrimary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_currentIndex + progress) / athkar.length,
                      backgroundColor: palette.surface,
                      valueColor: AlwaysStoppedAnimation(
                        palette.accentPrimary),
                      minHeight: 4,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: _showList
                      ? _buildList(athkar, palette, t)
                      : _buildDhikr(current, athkar.length, palette, t),
                ),

                if (!_showList)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _next(athkar.length),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color:        palette.accentPrimary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _currentIndex < athkar.length - 1
                                  ? t.athkarcat_next
                                  : t.athkarcat_finish,
                              style: TextStyle(
                                color:    palette.surface,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _currentIndex > 0 ? _prev : null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: _currentIndex > 0
                                  ? palette.surface
                                  : palette.surface.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              t.athkarcat_prev,
                              style: TextStyle(
                                color: _currentIndex > 0
                                    ? palette.textPrimary
                                    : palette.textSecondary,
                                fontSize: 14,
                              ),
                            ),
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
    );
  }

  Widget _buildList(List athkar, dynamic palette, AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color:        palette.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: athkar.length,
          separatorBuilder: (_, __) => Divider(
            color:  palette.background,
            height: 1,
          ),
          itemBuilder: (context, index) {
            final item      = athkar[index];
            final isCurrent = index == _currentIndex;

            return GestureDetector(
              onTap: () => _jumpTo(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
                color: isCurrent
                    ? palette.accentPrimary.withValues(alpha: 0.08)
                    : Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      width:  32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCurrent
                            ? palette.accentPrimary
                            : palette.accentPrimary.withValues(alpha: 0.15),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrent
                                ? palette.surface
                                : palette.accentPrimary,
                            fontSize:   12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.arabic,
                            textAlign:     TextAlign.right,
                            textDirection: TextDirection.rtl,
                            maxLines:      2,
                            overflow:      TextOverflow.ellipsis,
                            style: TextStyle(
                              color:      isCurrent
                                  ? palette.accentPrimary
                                  : palette.textPrimary,
                              fontSize:   15,
                              fontFamily: 'QuranFont',
                              height:     1.6,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            t.athkarcat_repeat(item.count, item.source),
                            style: TextStyle(
                              color:    palette.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.play_arrow,
                        color: palette.accentPrimary, size: 18),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDhikr(current, int total, dynamic palette, AppLocalizations t) {
    return GestureDetector(
      onTap: _completed
          ? null
          : () => _increment(current.count, total),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width:   double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(20),
            border: _completed
                ? Border.all(color: palette.accentPrimary, width: 1.5)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                current.arabic,
                textAlign:     TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   20,
                  height:     1.8,
                  fontFamily: 'QuranFont',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                t.athkarcat_narrated(current.source),
                style: TextStyle(
                  color:    palette.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _completed
                      ? palette.accentPrimary
                      : palette.accentPrimary.withValues(alpha: 0.15),
                ),
                child: Center(
                  child: _completed
                      ? Icon(Icons.check,
                          color: palette.surface, size: 32)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_currentCount',
                              style: TextStyle(
                                color:      palette.accentPrimary,
                                fontSize:   22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '/ ${current.count}',
                              style: TextStyle(
                                color:    palette.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _completed ? t.athkarcat_moving : t.athkarcat_tapCount,
                style: TextStyle(
                  color:    palette.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}