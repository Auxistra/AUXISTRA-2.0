class Song {
  final String id;
  final String title;
  final String artist;
  final String albumArt;
  final String audioUrl;
  final Map<String, String> stemUrls;
  final Map<String, double> stemVolumes;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    this.albumArt = '',
    required this.audioUrl,
    this.stemUrls = const {},
    Map<String, double>? stemVolumes,
  }) : this.stemVolumes = stemVolumes ?? {
          'Stem 1': 1.0,
          'Stem 2': 1.0,
          'Stem 3': 1.0,
          'Stem 4': 1.0,
        };
}
