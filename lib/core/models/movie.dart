import 'package:movies/core/models/torrent.dart';
import 'package:movies/features/movie_details/data/models/cast.dart';

class Movie {
  final int id;
  final String? url;
  final String? imdbCode;
  final String? title;
  final String? titleEnglish;
  final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String> genres;
  final int? likeCount;
  final String? summary;
  final String descriptionIntro;
  final String? descriptionFull;
  final String? synopsis;
  final String? ytTrailerCode;
  final String? language;
  final String? mpaRating;
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String smallCoverImage;
  final String? mediumCoverImage;
  final String? largeCoverImage;
  final String mediumScreenshotImage1;
  final String mediumScreenshotImage2;
  final String mediumScreenshotImage3;
  final String? largeScreenshotImage1;
  final String? largeScreenshotImage2;
  final String? largeScreenshotImage3;
  final List<Cast> cast;
  final String? state;
  final List<Torrent> torrents;

  const Movie({
    required this.id,
    this.url,
    this.title,
    this.year,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    required this.descriptionIntro,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.imdbCode,
    this.rating,
    this.runtime,
    required this.genres,
    this.likeCount,
    this.summary,
    this.descriptionFull,
    this.backgroundImageOriginal,
    required this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    required this.mediumScreenshotImage1,
    required this.mediumScreenshotImage2,
    required this.mediumScreenshotImage3,
    this.largeScreenshotImage1,
    this.largeScreenshotImage2,
    this.largeScreenshotImage3,
    required this.cast,
    this.state,
    required this.torrents,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'] as int,
    url: json['url'] as String?,
    imdbCode: json['imdb_code'] as String?,
    title: json['title'] as String?,
    titleEnglish: json['title_english'] as String?,
    titleLong: json['title_long'] as String?,
    slug: json['slug'] as String?,
    year: json['year'] as int?,
    rating: (json['rating'] as num?)?.toDouble(),
    runtime: json['runtime'] as int?,
    genres: (json['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
    likeCount: json['like_count'] as int?,
    summary: json['summary'] as String?,
    descriptionIntro: (json['description_intro'] as String?) ?? '',
    descriptionFull: json['description_full'] as String?,
    synopsis: json['synopsis'] as String? ?? '',
    ytTrailerCode: json['yt_trailer_code'] as String?,
    language: json['language'] as String?,
    mpaRating: json['mpa_rating'] as String?,
    backgroundImage: json['background_image'] as String?,
    backgroundImageOriginal: json['background_image_original'] as String?,
    smallCoverImage: (json['small_cover_image']  as String?)  ??
        'https://4ddig.tenorshare.com/images/photo-recovery/images-not-found.jpg',
    mediumCoverImage: json['medium_cover_image'] as String?,
    largeCoverImage: json['large_cover_image'] as String?,
    mediumScreenshotImage1: (json['medium_screenshot_image1'] as String?)  ??
        'https://4ddig.tenorshare.com/images/photo-recovery/images-not-found.jpg',
    mediumScreenshotImage2: (json['medium_screenshot_image2'] as String?)  ??
        'https://4ddig.tenorshare.com/images/photo-recovery/images-not-found.jpg',
    mediumScreenshotImage3: (json['medium_screenshot_image3'] as String?)  ??
        'https://4ddig.tenorshare.com/images/photo-recovery/images-not-found.jpg',
    largeScreenshotImage1: json['large_screenshot_image1'] as String?,
    largeScreenshotImage2: json['large_screenshot_image2'] as String?,
    largeScreenshotImage3: json['large_screenshot_image3'] as String?,
    cast:
        (json['cast'] as List<dynamic>?)
            ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    state: json['state'] as String?,
    torrents: (json['torrents'] as List<dynamic>?)
        ?.map((e) => Torrent.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
  );
}
