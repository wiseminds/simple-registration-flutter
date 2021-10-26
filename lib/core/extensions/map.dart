extension MapExt on Map<String, dynamic> {
  /// get a key from a map, this helper method reduces boilerplate code of
  /// having to check if a map is not null before accessing properties with the
  /// square bracket notation.
  T? getKey<T>(String key) {
    try {
      if (containsKey(key)) {
        return this[key];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
