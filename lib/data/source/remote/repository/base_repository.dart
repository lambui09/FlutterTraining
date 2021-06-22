import 'package:untitled/utils/constants.dart';

class KeyPrams {
  static const String imgPath = 'https://image.tmdb.org/t/p/w500/';
  static const String results = 'results';
  static const String apiKey = 'api_key';
  static const String page = 'page';
  static const String v4_list = '/4/list/';
}

Uri createUri(String path, [Map<String, String>? queryParameters]) {
  String baseUrl = Constants.instance.endpoint;
  String apiKey = Constants.instance.apiKey;

  Map<String, String> query = {KeyPrams.apiKey: apiKey};

  if (queryParameters != null) {
    query.addAll(queryParameters);
  }

  return Uri.https(baseUrl, path, query);
}

dynamic jsonDecode(Map<String, dynamic> json, String key) {
  try {
    dynamic data = json[key];
    if (data == null) {
      print('Parse Json Error with key: $key');
      return null;
    }
    return data;
  } on Exception catch (e) {
    print('Parse Json Error with key: $key');
  }
}
