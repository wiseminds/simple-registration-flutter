part of 'location_cubit.dart';

class LocationRepository extends DataRepository {
  LocationApiService apiService = LocationApiService();

  Future<ApiResponse<List<Location>, Location>> getLocation() async {
    return await handleRequest<List<Location>, Location>(
        () => apiService.getStates(),
        cache: CacheDescription('location', lifeSpan: CacheDescription.oneDay));
  }

  Future<ApiResponse<List<Location>, Location>> getLgaInState(
      String state) async {
    return await handleRequest<List<Location>, Location>(
        () => apiService.cities(state),
        cache: CacheDescription('location:$state',
            lifeSpan: CacheDescription.oneDay));
  }
}
