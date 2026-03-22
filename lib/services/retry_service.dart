import 'dart:async';

/// RetryService provides a utility for retrying asynchronous
/// operations (such as API calls) when they fail temporarily.
///
/// Example uses:
/// - Retrying song metadata fetch
/// - Retrying playlist updates
/// - Handling unstable network conditions
class RetryService {
  /// Executes [task] and retries it if it throws an error.
  ///
  /// [maxAttempts] determines how many times the task should retry.
  /// [delay] defines the base wait time between retries.
  static Future<T> runWithRetry<T>({
    required Future<T> Function() task,
    int maxAttempts = 3,
    Duration delay = const Duration(seconds: 2),
  }) async {
    int attempt = 0;

    while (true) {
      try {
        attempt++;

        /// Execute the task
        return await task();
      } catch (error) {
        /// If max attempts reached, rethrow error
        if (attempt >= maxAttempts) {
          rethrow;
        }

        /// Wait before retrying (exponential backoff)
        await Future.delayed(delay * attempt);
      }
    }
  }
}
