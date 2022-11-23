class Optional<T extends Object> {
  Optional(this.value);
  final T? value;

  U? map<U>(U? Function(T value) ifPresent) =>
      value != null ? ifPresent(value!) : null;
}
