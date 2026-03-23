import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/music_models.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';

enum AuxistraState { initial, loading, ready, error, buffering }

class MusicProvider extends ChangeNotifier {
  static const String _computerIp = '192.168.1.101';
  static String get baseUrl => kIsWeb ? 'http://localhost:3000' : 'http://$_computerIp:3000';

  final Map<String, AudioPlayer> _players = {
    'Stem 1': AudioPlayer(),
    'Stem 2': AudioPlayer(),
    'Stem 3': AudioPlayer(),
    'Stem 4': AudioPlayer(),
  };

  AuxistraState _state = AuxistraState.initial;
  Timer? _uiTimer;
  Timer? _precisionSyncTimer;

  List<Song> _allSongs = [];
  Song? _currentSong;
  bool _isPlaying = false;
  bool _isRemixing = false;
  double _masterVolume = 1.0;
  String _searchQuery = '';

  final StreamController<List<double>> _visualizerController = StreamController<List<double>>.broadcast();
  Stream<List<double>> get visualizerStream => _visualizerController.stream;

  Color _activeColor = const Color(0xFF3F00FF);
  Color get activeColor => _activeColor;

  MusicProvider() {
    _initEngine();
    fetchSongs();
  }

  void _initEngine() {
    _players['Stem 1']!.playerStateStream.listen((state) {
      if (state.playing != _isPlaying) {
        _isPlaying = state.playing;
        if (_isPlaying) _startSyncGuard(); else _stopSyncGuard();
        notifyListeners();
      }
      if (state.processingState == ProcessingState.buffering) {
        _state = AuxistraState.buffering;
        notifyListeners();
      } else if (state.processingState == ProcessingState.ready) {
        _state = AuxistraState.ready;
        notifyListeners();
      }
    });
  }

  void _startSyncGuard() {
    _uiTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (_isPlaying) _visualizerController.add(List.generate(12, (i) => math.Random().nextDouble()));
      notifyListeners();
    });

    _precisionSyncTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (!_isPlaying) return;
      final masterPos = _players['Stem 1']!.position;
      _players.forEach((name, player) {
        if (name != 'Stem 1') {
          final drift = (player.position - masterPos).inMilliseconds.abs();
          if (drift > 15) player.seek(masterPos);
        }
      });
    });
  }

  void _stopSyncGuard() {
    _uiTimer?.cancel();
    _precisionSyncTimer?.cancel();
    notifyListeners();
  }

  // --- GETTERS ---
  bool get isPlaying => _isPlaying;
  bool get isRemixing => _isRemixing;
  bool get isLoading => _state == AuxistraState.loading || _state == AuxistraState.buffering;
  Duration get position => _players['Stem 1']?.position ?? Duration.zero;
  Duration get duration => _players['Stem 1']?.duration ?? Duration.zero;
  Song? get currentSong => _currentSong;
  List<Song> get recentSongs => _allSongs;
  List<Song> get searchedSongs {
    if (_searchQuery.isEmpty) return _allSongs;
    return _allSongs.where((s) =>
      s.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      s.artist.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  // --- ACTIONS ---
  Future<void> playSong(Song song) async {
    _currentSong = song;
    _state = AuxistraState.loading;
    notifyListeners();

    _updateThemeColor(song.albumArt);

    try {
      await Future.wait(_players.values.map((p) => p.stop()));
      await Future.wait(song.stemUrls.entries.map((e) =>
        _players[e.key]!.setUrl(e.value, preload: true)));

      _players.forEach((name, player) => player.setVolume((song.stemVolumes[name] ?? 1.0) * _masterVolume));
      await Future.wait(_players.values.map((p) => p.seek(Duration.zero)));

      _state = AuxistraState.ready;
      notifyListeners();
      for (var p in _players.values) p.play();
    } catch (e) {
      _state = AuxistraState.error;
      notifyListeners();
    }
  }

  Future<void> _updateThemeColor(String imageUrl) async {
    if (imageUrl.isEmpty) return;
    try {
      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(imageUrl),
        size: const Size(200, 200),
        maximumColorCount: 20,
      );
      if (paletteGenerator.vibrantColor != null) {
        _activeColor = paletteGenerator.vibrantColor!.color;
      } else if (paletteGenerator.dominantColor != null) {
        _activeColor = paletteGenerator.dominantColor!.color;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error generating palette: $e');
    }
  }

  void searchSongs(String q) { _searchQuery = q; notifyListeners(); }
  void updateSearch(String q) { _searchQuery = q; notifyListeners(); }

  Future<void> addSong(String title, String artist, String audioUrl) async {
    final newSong = Song(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      artist: artist,
      albumArt: '',
      audioUrl: audioUrl,
    );
    _allSongs.insert(0, newSong);
    notifyListeners();
  }

  void togglePlay() {
    if (_isPlaying) { for (var p in _players.values) p.pause(); } else { for (var p in _players.values) p.play(); }
  }

  void seek(Duration pos) async {
    await Future.wait(_players.values.map((p) => p.seek(pos)));
    notifyListeners();
  }

  void updateStemVolume(String name, double volume) {
    if (_players.containsKey(name)) {
      _players[name]!.setVolume(volume * _masterVolume);
      _currentSong?.stemVolumes[name] = volume;
      notifyListeners();
    }
  }

  void toggleRemixMode(bool enable) {
    _isRemixing = enable;
    notifyListeners();
  }

  Future<void> fetchSongs() async {
    try {
      debugPrint('📡 PHONE ATTEMPTING TO REACH: $baseUrl/api/songs');
      final res = await http.get(Uri.parse('$baseUrl/api/songs')).timeout(const Duration(seconds: 5));
      if (res.statusCode == 200) {
        List data = json.decode(res.body);
        _allSongs = data.map<Song>((j) => Song(
          id: j['id']?.toString() ?? '',
          title: j['title'] ?? 'Untitled',
          artist: j['artist'] ?? 'Unknown',
          albumArt: j['albumArt'] ?? '',
          audioUrl: j['audioUrl'] ?? '',
          stemUrls: Map<String, String>.from(j['stemUrls'] ?? {}),
        )).toList();

        if (_allSongs.isNotEmpty && _currentSong == null) {
          _currentSong = _allSongs[0];
          _updateThemeColor(_currentSong!.albumArt);
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('❌ CONNECTION ERROR');
      _loadFallbackData();
    }
  }

  void _loadFallbackData() {
    _allSongs = [Song(id: 's1', title: 'Midnight Echo', artist: 'Neon Wave', albumArt: 'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?w=400', audioUrl: '$baseUrl/uploads/s1_main.wav', stemUrls: {'Stem 1': '$baseUrl/uploads/s1_stem1.wav','Stem 2': '$baseUrl/uploads/s1_stem2.wav','Stem 3': '$baseUrl/uploads/s1_stem3.wav','Stem 4': '$baseUrl/uploads/s1_stem4.wav'})];
    if (_currentSong == null) {
      _currentSong = _allSongs[0];
      _updateThemeColor(_currentSong!.albumArt);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    _precisionSyncTimer?.cancel();
    _visualizerController.close();
    for (var p in _players.values) p.dispose();
    super.dispose();
  }
}
