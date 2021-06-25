class InputException implements Exception {
  String message;

  InputException(String message) {
    this.message = message;
  }

  @override
  String toString() {
    return 'Error: $message';
  }
}
