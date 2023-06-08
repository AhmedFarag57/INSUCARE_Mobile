class ClientException implements Exception {
  String? _message;

  ClientException(String msg) {
    this._message = msg;
  }

  @override
  String toString() {
    return _message!;
  }
}
