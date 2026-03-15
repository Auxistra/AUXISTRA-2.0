import 'dart:collection';

/// CacheService stores frequently accessed data in memory
/// to improve performance and reduce unnecessary API calls.
///
/// Example uses:
/// - Caching album artwork URLs
/// - Storing track metadata
/// - Storing artist info temporarily
class CacheService {
  /// Internal map used for storing cached items
  final Map<String, dynamic> _cache = HashMap();

  /// Stores a value in the cache
  void set(String key, dynamic value) {
    _cache[key] = value;
  }

  /// Retrieves a value from the cache
  dynamic get(String key) {
    return _cache[key];
  }

  /// Checks if a key exists in the cache
  bool contains(String key) {
    return _cache.containsKey(key);
  }

  /// Clears all cached items
  void clear() {
    _cache.clear();
  }
}
