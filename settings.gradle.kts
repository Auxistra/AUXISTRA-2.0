pluginManagement {
    val flutterSdkPath = "C:/src/flutter"
    val userHome = System.getProperty("user.home").replace("\\", "/")
    val androidSdkPath = "$userHome/AppData/Local/Android/Sdk"

    // This block automatically fixes corrupted local.properties files
    listOf(file("local.properties"), file("android/local.properties")).forEach { f ->
        try {
            if (f.exists()) {
                val content = f.readText()
                if (content.contains("DELL") || content.contains("\\f")) {
                    f.writeText("flutter.sdk=$flutterSdkPath\nsdk.dir=$androidSdkPath\n")
                }
            } else {
                f.writeText("flutter.sdk=$flutterSdkPath\nsdk.dir=$androidSdkPath\n")
            }
        } catch (e: Exception) {
            println("Warning: Could not auto-fix ${f.path}: ${e.message}")
        }
    }

    System.setProperty("flutter.sdk", flutterSdkPath)
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.10" apply false
}

include(":app")
project(":app").projectDir = file("android/app")
