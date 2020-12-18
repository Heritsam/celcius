class ServerException implements Exception {
  final String message;
  final Map<String, dynamic> result;

  ServerException([this.message, this.result]);
}
