abstract class BaseRepository {
  static const String baseUrl = 'api.themoviedb.org';

  Uri createUri(String unencodedPath, [Map<String, String>? queryParameters]) {
    return Uri.https(baseUrl, unencodedPath, queryParameters);
  }
}
