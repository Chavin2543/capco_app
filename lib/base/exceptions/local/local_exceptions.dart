class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});
}

class MapException implements Exception {
  final String message = "Fail to Open External Map";

  const MapException();
}

class PhoneException implements Exception {
  final String message;

  const PhoneException({required this.message});
}

class MailException implements Exception {
  final String message;

  const MailException({required this.message});
}

class UrlException implements Exception {
  final String message;

  const UrlException({required this.message});
}