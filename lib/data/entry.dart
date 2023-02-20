import 'package:movie_app/extensions/datetime.dart';

class Entry {
  final String id;
  final String name;
  final String? description;
  final String ageRestriction;
  final Duration durationMinutes;
  final String thumbnailImageId;
  final List<String> genres;
  final List<String> tags;
  final DateTime? movieReleaseDate;
  final DateTime? ReleaseDate;
  final double trendingIndex;
  final bool isOriginal;
  final List<String> cast;

  bool isEmpty() {
    if(id.isEmpty || name.isEmpty) {
      return true;
    }
    return false;
  }

  Entry({
    required this.id,
    required this.name,
    this.description,
    required this.ageRestriction,
    required this.durationMinutes,
    required this.thumbnailImageId,
    required this.genres,
    required this.tags,
    this.movieReleaseDate,
    this.ReleaseDate,
    required this.trendingIndex,
    required this.isOriginal,
    required this.cast
  });

  static Entry empty() {
    return Entry(
      id: '',
      name: '',
      description: '',
      ageRestriction: '',
      durationMinutes: const Duration(minutes: -1),
      thumbnailImageId: '',
      genres: [],
      tags: [],
      trendingIndex: -1,
      isOriginal: false,
      cast: [],
    );
  }

  static Entry fromJson(Map<String, dynamic> data) {
    return Entry(
      id: data['\$id'],
      name: data['name'],
      description: data['description'],
      ageRestriction: data['ageRestriction'],
      durationMinutes: Duration(minutes: data['durationMinutes']),
      thumbnailImageId: data['thumbnailImageId'],
      genres: data['genres'].cast<String>(),
      tags: data['tags'].cast<String>(),
      movieReleaseDate: data['movieReleaseDate'] != null ? DateTimeExt.fromUnixTimestampInt(data['moviReleaseDate']): null,
      ReleaseDate: data['ReleaseDate'] != null ? DateTimeExt.fromUnixTimestampInt(data['ReleaseDate']) : null,
      trendingIndex: data['trendingIndex'],
      isOriginal: data['isOriginal'],
      cast: data['cast'].cast<String>(),
    );
  }
}