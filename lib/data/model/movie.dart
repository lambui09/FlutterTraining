class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String voteAverage;

  Movie(
    this.id,
    this.title,
    this.posterUrl,
    this.backdropUrl,
    this.voteAverage,
  );

  String firstAverage() => voteAverage.substring(0, 1);

  String lastAverage() =>
      voteAverage.substring(voteAverage.length - 1, voteAverage.length);
}
