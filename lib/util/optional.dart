class Optional<T> {
  static Optional<String> string(String value) =>
      Optional(value == '' ? null : value);

  Optional(this.value);
  final T? value;

  U? map<U>(U? Function(T value) ifPresent) {
    final value = this.value;
    return value != null ? ifPresent(value) : null;
  }
}
