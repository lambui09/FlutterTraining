import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

abstract class AppClient extends BaseClient {
  Future<dynamic> getItem(Uri uri, [Map<String, String>? headers]) {
    print("getItem");
    return this.get(
      uri,
      headers: {
        ...?headers,
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
    ).then(_processData);
  }

  Future<dynamic> postItem(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    return this
        .post(
          url,
          headers: {
            ...?headers,
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
          body: jsonEncode(body),
        )
        .then(_processData);
  }

  Future<dynamic> putItem(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) =>
      this
          .put(
            url,
            headers: {
              ...?headers,
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
            body: body != null ? jsonEncode(body) : null,
          )
          .then(_processData);

  Future<dynamic> deleteItem(dynamic url, {Map<String, String>? headers}) =>
      this.delete(
        url,
        headers: {
          ...?headers,
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ).then(_processData);

  static dynamic _processData(Response response) {
    final statusCode = response.statusCode;
    final json = jsonDecode(response.body);

    if (HttpStatus.ok <= statusCode &&
        statusCode <= HttpStatus.multipleChoices) {
      return json;
    }

    final request = response.request;

    // TODO handle error Response
    print('requestError: $request errorResponse=$response');
    // TODO Throw error
    throw Future.error(response.statusCode);
  }
}

class ApiService extends AppClient {
  final Client _client = Client();
  final Duration _timeout = const Duration(seconds: 60);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    print("send");
    // TODO await _getToken
    final token = null;

    if (token != null) {
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';

    print('Request--------- $request');
    return _client.send(request).timeout(_timeout).then(_processResponse);
  }

  Future<StreamedResponse> _processResponse(StreamedResponse response) async {
    print('Response--------- ${response.statusCode} ${response.request}');

    if (response.statusCode == HttpStatus.unauthorized ||
        response.statusCode == HttpStatus.forbidden) {
      // TODO await _logOut
      print('Unauthorized');
    }

    return response;
  }
}
