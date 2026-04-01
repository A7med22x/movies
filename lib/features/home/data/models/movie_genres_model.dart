class MovieGenresModel {
  final String name;

  const MovieGenresModel(this.name);

  static List<MovieGenresModel> genres = [
    MovieGenresModel('All'),
    MovieGenresModel('Action'),
    MovieGenresModel('Comedy'),
    MovieGenresModel('Horror'),
    MovieGenresModel('Sci-Fi'),
    MovieGenresModel('Thriller'),
    MovieGenresModel('Romance'),
    MovieGenresModel('Crime'),
    MovieGenresModel('Animation'),
    MovieGenresModel('Adventure'),
    MovieGenresModel('Sport'),
    MovieGenresModel('Fantasy'),
    MovieGenresModel('Documentary'),
  ];
}
