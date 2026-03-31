class Cast {
  final String name;
  final String characterName;
  final String urlSmallImage;
  final String imdbCode;

  const Cast({
    required this.name,
    required this.characterName,
    required this.urlSmallImage,
    required this.imdbCode,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    name: (json['name'] as String?) ?? '',
    characterName: (json['character_name'] as String?) ?? '',
    urlSmallImage:
        (json['url_small_image'] as String?) ??
        'https://4ddig.tenorshare.com/images/photo-recovery/images-not-found.jpg',
    imdbCode: (json['imdb_code'] as String?) ?? '',
  );
}
