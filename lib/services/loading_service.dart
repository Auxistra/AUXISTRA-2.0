import 'package:flutter/foundation.dart';

/// LoadingService manages application-wide loading states.
///
/// This helps ensure that:
/// - Multiple network calls don't overlap badly
/// - UI can react to loading states
/// - Loading overlays can be displayed globally
class LoadingService extends ChangeNotifier {
  bool _isLoading = false;

  /// Returns whether a loading operation is active
  bool get isLoading => _isLoading;

  /// Starts loading
  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  /// Stops loading
  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
