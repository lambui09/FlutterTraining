class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String voteAverage;
  final String overview;
  final String releaseDate;
  final int voteCount;
  final double popularity;

  Movie(
    this.id,
    this.title,
    this.posterUrl,
    this.backdropUrl,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.voteCount,
    this.popularity,
  );

  String firstAverage() => voteAverage.substring(0, 1);

  String lastAverage() =>
      voteAverage.substring(voteAverage.length - 1, voteAverage.length);

  String get imageUrl => backdropUrl.isNotEmpty ? posterUrl : backdropUrl;
}
