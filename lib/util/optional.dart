class Optional<T extends Object> {
  static Optional<String> string(String value) =>
      Optional(value == '' ? null : value);

  Optional(this.value);
  final T? value;

  U? map<U>(U? Function(T value) ifPresent) =>
      value != null ? ifPresent(value!) : null;
}
