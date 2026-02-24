import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';
  static const Duration timeoutDuration = Duration(seconds: 10);

  static final http.Client _client = http.Client();

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
      };

  // USER 

  static Future<Map<String, dynamic>> syncUser(
      String uid, String email, String name) async {
    final url = Uri.parse('$baseUrl/users/sync');

    try {
      final response = await _client
          .post(
            url,
            headers: _headers,
            body: jsonEncode({
              'uid': uid,
              'email': email,
              'name': name,
            }),
          )
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to sync user: $e');
    }
  }

  static Future<void> upgradeToArtist(String uid) async {
    final url = Uri.parse('$baseUrl/users/$uid/upgrade');

    try {
      final response = await _client
          .post(url, headers: _headers)
          .timeout(timeoutDuration);

      _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to upgrade user: $e');
    }
  }

  // ANALYTICS 

  static Future<Map<String, dynamic>> getAnalytics(String artistUid) async {
    final url = Uri.parse('$baseUrl/artists/$artistUid/analytics');

    try {
      final response = await _client
          .get(url, headers: _headers)
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch analytics: $e');
    }
  }

  // UPLOAD 

  static Future<String> getUploadUrl(String fileName, String fileType) async {
    final url = Uri.parse('$baseUrl/upload/url');

    try {
      final response = await _client
          .post(
            url,
            headers: _headers,
            body: jsonEncode({
              'fileName': fileName,
              'fileType': fileType,
            }),
          )
          .timeout(timeoutDuration);

      final data = _handleResponse(response);
      return data['uploadUrl'];
    } catch (e) {
      throw Exception('Failed to get upload URL: $e');
    }
  }

  // PAYMENTS

  static Future<String> createStripeSession(int songId, int price) async {
    final url = Uri.parse('$baseUrl/payments/stripe-session');

    try {
      final response = await _client
          .post(
            url,
            headers: _headers,
            body: jsonEncode({
              'songId': songId,
              'price': price,
            }),
          )
          .timeout(timeoutDuration);

      final data = _handleResponse(response);
      return data['sessionId'];
    } catch (e) {
      throw Exception('Failed to create Stripe session: $e');
    }
  }

  // HELPER

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'API Error ${response.statusCode}: ${response.body}');
    }
  }

  // Optional: Call when app closes
  static void dispose() {
    _client.close();
  }
}
