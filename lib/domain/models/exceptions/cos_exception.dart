import 'dart:io';

class CosException implements Exception {
  final String message;

  const CosException(this.message);
  CosException.fromHttpException(HttpException exception)
    : message = exception.message;
}
