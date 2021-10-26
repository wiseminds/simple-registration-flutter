import 'package:challenge/data/remote/provider/api_request.dart';

import '../provider/api_response.dart';

abstract class ApiInterceptor {
  ApiRequest<ResponseType, InnerType> onRequest<ResponseType, InnerType>(
          ApiRequest<ResponseType, InnerType> request) =>
      request;
  ApiResponse<ResponseType, InnerType> onResponse<ResponseType, InnerType>(
          ApiResponse<ResponseType, InnerType> response) =>
      response;
  ApiResponse<ResponseType, InnerType> onError<ResponseType, InnerType>(
          ApiResponse<ResponseType, InnerType> response) =>
      response;
}
