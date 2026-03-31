import 'package:movies/features/home/data/models/torrent.dart';

class Movie {
  final int? id;
  final String? url;
  final String? imdbCode;
  final String? title;
  final String? titleEnglish;
  final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final String? summary;
  final String? descriptionFull;
  final String? synopsis;
  final String? ytTrailerCode;
  final String? language;
  final String? mpaRating;
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String? smallCoverImage;
  final String? mediumCoverImage;
  final String? largeCoverImage;
  final String? state;
  final List<Torrent>? torrents;
  final String? dateUploaded;
  final int? dateUploadedUnix;

  const Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'] as int?,
    url: json['url'] as String?,
    imdbCode: json['imdb_code'] as String?,
    title: json['title'] as String,
    titleEnglish: json['title_english'] as String?,
    titleLong: json['title_long'] as String?,
    slug: json['slug'] as String,
    year: json['year'] as int,
    rating: (json['rating'] as num?)?.toDouble(),
    runtime: json['runtime'] as int?,
    genres: (json['genres'] as List?)?.map((e) => e.toString()).toList(),
    summary: json['summary'] as String?,
    descriptionFull: json['description_full'] as String?,
    synopsis: json['synopsis'] as String?,
    ytTrailerCode: json['yt_trailer_code'] as String?,
    language: json['language'] as String?,
    mpaRating: json['mpa_rating'] as String?,
    backgroundImage: json['background_image'] as String?,
    backgroundImageOriginal: json['background_image_original'] as String?,
    smallCoverImage: json['small_cover_image'] as String?,
    mediumCoverImage: json['medium_cover_image'] as String?,
    largeCoverImage: json['large_cover_image'] as String?,
    state: json['state'] as String?,
    torrents: (json['torrents'] as List<dynamic>?)
        ?.map((e) => Torrent.fromJson(e as Map<String, dynamic>))
        .toList(),
    dateUploaded: json['date_uploaded'] as String?,
    dateUploadedUnix: json['date_uploaded_unix'] as int?,
  );
}
