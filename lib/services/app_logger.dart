import 'package:flutter/foundation.dart';

/// Simple logging utility used to track application behavior.
/// Helps developers debug the system.
class AppLogger {

  /// Log normal information
  static void info(String message) {
    if (kDebugMode) {
      debugPrint("INFO: $message");
    }
  }

  /// Log warnings
  static void warning(String message) {
    if (kDebugMode) {
      debugPrint("WARNING: $message");
    }
  }

  /// Log errors
  static void error(String message) {
    if (kDebugMode) {
      debugPrint("ERROR: $message");
    }
  }
}
