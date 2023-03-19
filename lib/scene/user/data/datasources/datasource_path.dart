import '../../../../base/exceptions/network/network_exceptions.dart';

enum DataSourcePath {
  getUser
}

extension DataSourcePathExtension on DataSourcePath {
  String getPathString() {
    switch (this) {
      case DataSourcePath.getUser:
        return "";
    }
  }
}