import 'dart:async';

import 'package:challenge/models/error_model.dart';
import 'package:flutter/foundation.dart';

import '../data_repository.dart';
import 'exception_formater.dart';
import 'provider/api_request.dart';
import 'provider/api_response.dart';

///  for Remote Repository
class RemoteRepository with ExceptionFormater {
  /// makes a network request
  Future<ApiResponse<ResultType, Item>> handleRequest<ResultType, Item>(
      NetworkCall<ApiResponse<ResultType, Item>> networkCall,
      {int timeout = 50,
      bool retry = false}) async {
    ApiResponse<ResultType, Item> response;
    try {
      response = await networkCall().timeout(Duration(seconds: timeout),
          onTimeout: () {
        throw (TimeoutException('Connection timed out'));
      });
    } catch (e) {
      if (kDebugMode) print(' error in request ');
      if (kDebugMode) print(e.toString());
      response = ApiResponse<ResultType, Item>(
          bodyString: null,
          request: ApiRequest.dummy(),
          error: formatErrorMessage(e),
          headers: {},
          statusCode: 200);
    }
    if (kDebugMode) {
      print(
          'Finished request, url:${response.request?.path}, reqBody:${response.request?.body}, resBody:${response.bodyString}');
    }
    print('${response.error}');
    return response;
  }

  ApiResponse<ResultType, Item> handleError<ResultType, Item>(
      ApiResponse<ResultType, Item> response) {
    dynamic? error;
    if (response.error is ErrorModel) {
      error = (response.error as ErrorModel);
    } else {
      error = formatErrorMessage(response.error);
    }

    if ((response.statusCode ?? 500) > 490) {
      // error = Error();
      // Log.uploadLog('API Error', response.bodyString?.toString() ?? '');
    }
    return response.copyWith(error: error);
  }
}
