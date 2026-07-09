import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// شاشة القبلة - معطّلة مؤقتاً (يوليو 2026).
///
/// السبب: حزمة flutter_qiblah غير متوافقة مع AGP 9 (تسبّب فشل كامل
/// للبناء الإنتاجي - TD-01). أُزيلت الحزمة لفتح طريق البناء.
///
/// الكود الأصلي محفوظ في تاريخ Git (قبل هذا التعديل) للرجوع إليه.
/// البديل المخطط: تقييم islamic_kit أو حساب اتجاه القبلة يدوياً
/// (رياضيات بسيطة معروفة: bearing إلى الكعبة من الإحداثيات).
/// راجع docs/CONTENT_SOURCES.md و docs/05_TECH_DEBT.md (TD-01).
class QiblaScreen extends StatelessWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('اتجاه القبلة'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore_off, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'هذه الميزة قيد التطوير حالياً',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'سنعيدها قريباً بحل أكثر استقراراً',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
