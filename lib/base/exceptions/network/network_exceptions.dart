class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});
}

class InvalidPathException implements Exception {
  final String message = "Path is Invalid";

  const InvalidPathException();
}