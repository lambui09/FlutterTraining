class ApiResponse<T> {
  T? data;

  ApiResponse({
    required this.data,
  });

  factory ApiResponse.fromJson(dynamic json) => ApiResponse(
        data: json["results"],
      );
}
