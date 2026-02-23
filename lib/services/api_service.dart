import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<Map<String, dynamic>> syncUser(String uid, String email, String name) async {
    // Mocking the backend response
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'is_artist': false,
    };
  }

  static Future<void> upgradeToArtist(String uid) async {
    // Mocking the backend response
    await Future.delayed(const Duration(milliseconds: 800));
  }

  static Future<Map<String, dynamic>> getAnalytics(String artistUid) async {
    // Mocking the backend response
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'totalStreams': 1254300,
      'totalRevenue': 4520.50,
      'activeListeners': 45200,
    };
  }

  static Future<String> getUploadUrl(String fileName, String fileType) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return 'https://mock-s3-url.com/upload/$fileName';
  }

  static Future<String> createStripeSession(int songId, int price) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return 'mock_stripe_session_id';
  }
}
