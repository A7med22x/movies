class UserModel {
  String id;
  String name;
  String email;
  String phoneNumber;
  String? imageAvatarURL;
  List<String>? favoriteMoviesIds;
  List<String>? moviesWatchedHistoryIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.imageAvatarURL,
    this.favoriteMoviesIds,
    this.moviesWatchedHistoryIds,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        imageAvatarURL: json['imageAvatarURL'],
        favoriteMoviesIds: (json['favoriteMoviesIds'] as List? ?? []).cast<String>(),
        moviesWatchedHistoryIds: (json['moviesWatchedHistoryIds'] as List? ?? []).cast<String>(),
      );

  Map<String, dynamic> tojson() => {
    'id': id,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'imageAvatarURL': imageAvatarURL,
    'favoriteMoviesIds': favoriteMoviesIds,
    'moviesWatchedHistoryIds': moviesWatchedHistoryIds,
  };
}
