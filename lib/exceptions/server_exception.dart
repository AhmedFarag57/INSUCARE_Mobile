class ServerException implements Exception {
  String? _message;

  ServerException(String msg) {
    this._message = msg;
  }

  @override
  String toString() {
    return _message!;
  }
}
