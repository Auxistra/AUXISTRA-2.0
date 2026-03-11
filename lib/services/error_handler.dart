import 'package:flutter/foundation.dart';

/// Handles uncaught errors across the entire application.
/// This prevents silent crashes and helps debugging.
class ErrorHandler {

  /// Initializes global error handling
  static void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) {
      handleError(details.exception, details.stack);
    };
  }

  /// Handles the error safely
  static void handleError(Object error, StackTrace? stackTrace) {

    /// Print errors only in debug mode
    if (kDebugMode) {
      debugPrint("Application Error: $error");
      debugPrint("StackTrace: $stackTrace");
    }

    /// In production you could send this error
    /// to monitoring services like Firebase Crashlytics
  }
}
