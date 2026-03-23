import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/music_models.dart';

class MusicService {
  static const String _baseUrl = 'http://api.auxistra.com/api'; // Future production URL

  Future<List<Song>> fetchTrendingSongs() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/songs/trending'));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((item) => Song(
          id: item['id'],
          title: item['title'],
          artist: item['artist'],
          albumArt: item['coverArt'],
          audioUrl: item['audioUrl'],
        )).toList();
      }
      return [];
    } catch (e) {
      print('Production Error: $e');
      return [];
    }
  }

  Future<bool> uploadStem(String songId, String stemType, String filePath) async {
    // Logic for production multipart upload
    return true;
  }
}
