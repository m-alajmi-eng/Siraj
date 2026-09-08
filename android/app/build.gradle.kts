import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// توقيع الإصدار الحقيقي - يقرأ من android/key.properties (مستثنى من git عبر
// android/.gitignore وroot .gitignore، لا يُدفَع أبداً). محلياً يحتوي مسار
// الـkeystore الفعلي وكلمة المرور؛ في CI يُعاد بناؤه من أسرار GitHub Actions
// قبل خطوة البناء (انظر .github/workflows/ci.yml).
//
// ⚠️ 2026-09-08: اكتُشف فعلياً (فشل بناء حقيقي بـCI بعد تحديث قناة Flutter
// stable من 3.47.0 إلى 3.47.2) أن إسناد signingConfigs.getByName("release")
// لـbuildTypes.release دون تعيين storeFile يُسقِط البناء بالكامل الآن
// ("SigningConfig \"release\" is missing required property \"storeFile\"")
// بدل تجاهله بصمت كما كان بإصدارات AGP/Gradle الأقدم المرفقة بقنوات Flutter
// السابقة - تغيّر سلوك الأداة نفسها، لا خطأ بمنطقنا. **الحل**: العودة لتوقيع
// debug القياسي (توقيع Flutter الافتراضي لأي مشروع جديد) حين غاب الملف، بدلاً
// من إسناد إعداد توقيع فارغ يُسقِط Gradle. هذا **لا يُضعِف التحقق الفعلي من
// التوقيع الإصداري الحقيقي** - خطوة "Verify release signing" المنفصلة بـCI
// (تُشغَّل يدوياً فقط عبر workflow_dispatch الآن) تبقى كما هي بالضبط وتفشل
// بوضوح صراحةً حين يغيب key.properties، وهي آلية التحقق المقصودة أصلاً - لا
// إسقاط بناء Gradle الخام. توقيع الإصدار الحقيقي المطلوب فعلياً للنشر على
// المتجر يبقى محصوراً بوجود أسرار KEYSTORE_* الحقيقية.
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "app.siraj.siraj"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "app.siraj.siraj"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (keystorePropertiesFile.exists())
                signingConfigs.getByName("release")
            else
                signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    // مطلوبة لـ flutter_local_notifications (Core Library Desugaring)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
