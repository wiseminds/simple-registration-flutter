extension ToIntExt on dynamic {
  /// attempt converting a dynamic object to an integer
  int? get asInt {
    try {
      if (this is String) return int.tryParse(this);
      return this as int;
    } catch (e) {
      return null;
    }
  }
}
