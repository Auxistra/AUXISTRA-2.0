import 'package:auxistra/providers/music_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MusicProvider local state behaviour', () {
    test('addSong inserts a new song at the top of the library', () async {
      final provider = MusicProvider();

      addTearDown(provider.dispose);

      final initialCount = provider.recentSongs.length;

      await provider.addSong(
        'Coursework Test Song',
        'QA Artist',
        'https://example.com/audio.mp3',
      );

      expect(provider.recentSongs.length, initialCount + 1);
      expect(provider.recentSongs.first.title, 'Coursework Test Song');
      expect(provider.recentSongs.first.artist, 'QA Artist');
      expect(
        provider.recentSongs.first.audioUrl,
        'https://example.com/audio.mp3',
      );
    });

    test('searchSongs filters by title and artist without network data', () async {
      final provider = MusicProvider();

      addTearDown(provider.dispose);

      await provider.addSong(
        'Sunrise Pulse',
        'Aurora Lane',
        'https://example.com/one.mp3',
      );
      await provider.addSong(
        'Night Drive',
        'Neon Horizon',
        'https://example.com/two.mp3',
      );

      provider.searchSongs('sunrise');
      expect(provider.searchedSongs.length, 1);
      expect(provider.searchedSongs.first.title, 'Sunrise Pulse');

      provider.searchSongs('neon');
      expect(provider.searchedSongs.length, 1);
      expect(provider.searchedSongs.first.artist, 'Neon Horizon');

      provider.searchSongs('');
      expect(provider.searchedSongs.length, provider.recentSongs.length);
    });

    test('toggleRemixMode updates remix state predictably', () {
      final provider = MusicProvider();

      addTearDown(provider.dispose);

      expect(provider.isRemixing, isFalse);

      provider.toggleRemixMode(true);
      expect(provider.isRemixing, isTrue);

      provider.toggleRemixMode(false);
      expect(provider.isRemixing, isFalse);
    });
  });
}
