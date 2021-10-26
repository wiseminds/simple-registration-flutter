import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'local/local_repository.dart';
import 'remote/exception_formater.dart';
import 'remote/interceptors/json_interceptor.dart';
import 'remote/provider/api_request.dart';
import 'remote/provider/api_response.dart';
import 'remote/remote_repository.dart';

typedef NetworkCall<T> = Future<T> Function();

abstract class DataRepository with ExceptionFormater {
  final LocalRepository _localRepository = GetIt.I<LocalRepository>();
  final RemoteRepository _remoteRepository = RemoteRepository();

  /// manages fetching data, decides where to fetch data from
  Future<ApiResponse<ResultType, Item>> handleRequest<ResultType, Item>(
      NetworkCall<ApiResponse<ResultType, Item>> networkCall,
      {CacheDescription? cache,
      int timeout = 50,
      bool retry = false}) async {
    /// fetches data from cache if a valid cached data exists
    if (await shouldUseCache(cache)) {
      if (kDebugMode) print('fetching data from cache');
      var data = await _localRepository.getData(cache!.key);
      data = JsonInterceptor.convertFromJson<ResultType, Item>(data);
      if (data != null && data is ResultType) {
        return ApiResponse<ResultType, Item>(
                request: ApiRequest.dummy(),
                bodyString: data,
                headers: {},
                statusCode: 200)
            .resolve;
      }
      _localRepository.removeData(cache.key);
    }

    /// else fetches data from the remote source
    ApiResponse<ResultType, Item> response = await _remoteRepository
        .handleRequest<ResultType, Item>(networkCall, timeout: timeout);

    if (kDebugMode) print(response.bodyString);

    if (!response.isSuccessful) {
      response = _remoteRepository.handleError(response);
    }

    if (kDebugMode) print(response.error);
    if (kDebugMode) print(' finished request');

    if (cache != null && cache.key.isNotEmpty && response.body != null) {
      var data = validateData<ResultType, Item>(response);
      String json = JsonInterceptor.convertToJson(data);
      if (kDebugMode) print('cache: ${cache.key}, $json');
      _localRepository.saveData(cache.key, json);
      _localRepository.saveTime(
          cache.key, Duration(seconds: cache.lifeSpan).inSeconds);
    }
    return response;
  }

  /// validate data to be saved to cache is not an empty list
  ResultType? validateData<ResultType, Item>(
      ApiResponse<ResultType, Item> response) {
    dynamic data = response.body;
    if (ResultType is List<Item>) {
      if ((data as List).isEmpty) return null;
    }
    return data;
  }

  Future<bool> shouldUseCache(CacheDescription? cache) async {
    if (cache == null || cache.key.isEmpty) return false;
    if (kDebugMode) print('cache: ${cache.key}');
    return await _localRepository.checkCache(cache.key);
  }
}
