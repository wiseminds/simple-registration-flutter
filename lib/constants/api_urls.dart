class ApiUrls {
  static const states = 'api/location/states';
  static cities(String state) => 'api/location/states/$state/lga';
}
