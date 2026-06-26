import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/mosques_provider.dart';

class MosquesScreen extends ConsumerStatefulWidget {
  const MosquesScreen({super.key});

  @override
  ConsumerState<MosquesScreen> createState() => _MosquesScreenState();
}

class _MosquesScreenState extends ConsumerState<MosquesScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {
      _load();
    }
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    await ref.read(mosquesProvider.notifier).fetchNearbyMosques();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(timeThemeProvider);
    final mosques = ref.watch(mosquesProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [

            // ─── Header ───────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                      color: palette.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'المساجد القريبة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh,
                      color: palette.accentPrimary),
                    onPressed: _isLoading ? null : _load,
                  ),
                ],
              ),
            ),

            // ─── Linux Warning ────────────────────────
            if (!Platform.isAndroid && !Platform.isIOS)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:        palette.accentPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: palette.accentPrimary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'هذه الميزة تعمل على Android و iOS فقط',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color:    palette.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.info_outline,
                      color: palette.accentPrimary),
                  ],
                ),
              ),

            // ─── Loading ──────────────────────────────
            if (_isLoading)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: palette.accentPrimary),
                      const SizedBox(height: 16),
                      Text(
                        'جاري البحث عن المساجد القريبة...',
                        style: TextStyle(
                          color:    palette.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )

            // ─── Empty ────────────────────────────────
            else if (mosques.isEmpty &&
                (Platform.isAndroid || Platform.isIOS))
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.mosque,
                        size:  64,
                        color: palette.textSecondary),
                      const SizedBox(height: 16),
                      Text(
                        'لم يتم العثور على مساجد قريبة',
                        style: TextStyle(
                          color:    palette.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _load,
                        child: Text(
                          'حاول مجدداً',
                          style: TextStyle(
                            color: palette.accentPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              )

            // ─── قائمة المساجد ────────────────────────
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: mosques.length,
                  itemBuilder: (_, i) {
                    final mosque = mosques[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:        palette.surface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width:  44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: palette.accentPrimary
                                  .withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.mosque,
                              color: palette.accentPrimary,
                              size:  22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              mosque.name,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:      palette.textPrimary,
                                fontSize:   15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
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