import 'package:untitled/data/source/remote/repository/base_repository.dart';

enum AppErrorType {
  network,
  unauthorized,
  server,
  unknown,
}

class ErrorResponse {
  final int statusCode;
  final String message;

  ErrorResponse({
    required this.statusCode,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        statusCode: jsonDecode(json, "status_code"),
        message: jsonDecode(json, "status_message"),
      );

  AppError toAppError() {
    return AppError(message: this.message, type: AppErrorType.server);
  }
}

class AppError {
  final String message;
  final AppErrorType type;

  AppError({
    required this.message,
    required this.type,
  });

  factory AppError.toUnknown() => AppError(
        message: "Unknown Exception",
        type: AppErrorType.unknown,
      );

  factory AppError.toUnauthorized() => AppError(
        message: "Unauthorized 401",
        type: AppErrorType.unauthorized,
      );
}
