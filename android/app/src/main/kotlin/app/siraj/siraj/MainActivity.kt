package app.siraj.siraj

import com.ryanheise.audioservice.AudioServiceActivity

// audio_service يتطلّب أن يوفّر الـActivity الـFlutterEngine المشترك الذي
// تديره الخدمة الخلفية (AudioService)؛ AudioServiceActivity توفّر ذلك عبر
// provideFlutterEngine. بدونها يفشل AudioService.init عند الإقلاع بخطأ
// "Activity class ... is wrong or has not provided the correct FlutterEngine".
// راجع: https://pub.dev/packages/audio_service (قسم Custom Android activity)
class MainActivity : AudioServiceActivity()
