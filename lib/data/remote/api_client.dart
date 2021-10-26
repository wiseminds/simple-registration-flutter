import 'package:challenge/core/env.dart';
import 'package:get_it/get_it.dart';
import 'interceptors/header_interceptor.dart';
import 'provider/api_request.dart';

class ApiClient {
  static var env = GetIt.I.get<Env>();
  static ApiRequest<ResponseType, InnerType>
      baseRequestNoAuth<ResponseType, InnerType>() =>
          ApiRequest<ResponseType, InnerType>(
            baseUrl: env.baseUrl,
            dataKey: 'data',
            interceptors: [
              HeaderInterceptor({
                "Content-Type": "application/json",
                "Accept": "application/json",
              }),
              // AuthInterceptor(),
            ],
          );
  static ApiRequest<ResponseType, InnerType>
      baseRequest<ResponseType, InnerType>() =>
          ApiRequest<ResponseType, InnerType>(
            baseUrl: env.baseUrl,
            dataKey: 'data',
            interceptors: [
              HeaderInterceptor({
                // 'Authorization': 'Bearer ${GetIt.I<AuthBloc>().state.token}',
                "Content-Type": "application/json",
                "Accept": "application/json",
              }),
              // AuthInterceptor(),
            ],
          );
}
