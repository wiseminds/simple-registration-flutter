
extension Str on String {
  // capitalize first letter of a every word in a string
  String toTitleCase() {
    List<String> s =  toLowerCase().split(' ');
    String result = '';
    for (var e in s) {
      result += e.replaceRange(0, 1, e[0].toUpperCase());
      result += ' ';
    }
    return result.trim();
  }

  String get normalizeUrl {
    return replaceAll('//', '//');
  }
 
}
