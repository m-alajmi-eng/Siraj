import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../l10n/app_localizations.dart';

/// يفتح حواراً بسيطاً يسمح للمستخدم بالإبلاغ عن خطأ في ترجمة آية
/// معيّنة بلغة معيّنة. يُدرَج البلاغ في جدول translation_reports
/// (انظر migration المرفقة) لمراجعة بشرية لاحقة - لا حل تلقائي.
Future<void> showTranslationReportDialog(
  BuildContext context, {
  required String languageCode,
  required int surahId,
  required int ayahNumber,
}) async {
  final t = AppLocalizations.of(context);
  final issueController = TextEditingController();
  final noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final submitted = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(t.portal_reportDialogTitle),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: issueController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: t.portal_reportIssueLabel,
                hintText: t.portal_reportIssueHint,
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? t.portal_reportIssueRequired : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: noteController,
              maxLines: 2,
              decoration: InputDecoration(labelText: t.portal_reportNoteLabel),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(t.portal_reportCancel),
        ),
        FilledButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.of(dialogContext).pop(true);
            }
          },
          child: Text(t.portal_reportSubmit),
        ),
      ],
    ),
  );

  if (submitted != true) return;

  try {
    await Supabase.instance.client.from('translation_reports').insert({
      'language_code': languageCode,
      'surah_id': surahId,
      'ayah_number': ayahNumber,
      'reported_issue_text': issueController.text.trim(),
      'reporter_note': noteController.text.trim().isEmpty
          ? null
          : noteController.text.trim(),
    });
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.portal_reportSuccess)));
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.portal_reportError)));
    }
  }
}
