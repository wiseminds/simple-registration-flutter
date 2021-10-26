import 'package:challenge/data/remote/interceptors/api_interceptor.dart';
import 'package:challenge/core/extensions/index.dart';

import 'api_methods.dart';

class ApiRequest<ResponseType, InnerType> {
  /// https methods including [get, post, put, delete, patch]
  final String? method;

  /// api path
  final String path;

  /// api timeout
  final int timeout;

  /// api key to use in serializing json
  final String dataKey;

  /// if actual data is nested, key to serialize first before serializing actual json
  final String? nestedKey;

  /// request base url
  final String baseUrl;
  final bool hasPagination;

  /// request body
  final Map<String, dynamic>? body;

  /// request headers
  final Map<String, String> headers;

  /// request query parameters
  final Map<String, dynamic> query;

  /// request interceptors
  final List<ApiInterceptor> interceptors;

  /// request extra metadata passed in with request
  final List<Extra>? extra;
  final ErrorDescription? error;

  /// specifies if request is a multipart request, for instance a file upload request
  final bool isMultipart;

  ApiRequest(
      {this.hasPagination = false,
      this.isMultipart = false,
      this.extra,
      this.headers = const {},
      this.query = const {},
      this.error,
      this.method = ApiMethods.get,
      this.dataKey = '',
      this.interceptors = const [],
      this.path = '',
      this.nestedKey,
      required this.baseUrl,
      this.timeout = 50,
      this.body});

  factory ApiRequest.dummy() => ApiRequest<ResponseType, InnerType>(
      hasPagination: false,
      headers: {},
      query: {},
      method: ApiMethods.get,
      dataKey: '',
      isMultipart: false,
      path: '',
      baseUrl: '');

  ApiRequest<ResponseType, InnerType> copyWith(
          {String? method,
          String? path,
          String? dataKey,
          String? baseUrl,
          bool? hasPagination,
          String? nestedKey,
          List<Extra>? extra,
          int? timeout,
          bool? isMultipart,
          Map<String, dynamic>? body,
          Map<String, String>? headers,
          List<ApiInterceptor>? interceptors,
          ErrorDescription? error,
          Map<String, dynamic>? query}) =>
      ApiRequest<ResponseType, InnerType>(
          hasPagination: hasPagination ?? this.hasPagination,
          headers: headers ?? this.headers,
          query: query ?? this.query,
          method: method ?? this.method,
          dataKey: dataKey ?? this.dataKey,
          isMultipart: isMultipart ?? this.isMultipart,
          path: path ?? this.path,
          nestedKey: nestedKey ?? this.nestedKey,
          extra: extra ?? this.extra,
          error: error ?? this.error,
          timeout: timeout ?? this.timeout,
          baseUrl: baseUrl ?? this.baseUrl,
          interceptors: [...?interceptors, ...this.interceptors],
          body: body ?? this.body);

  ApiRequest<ResponseType, InnerType> get build {
    print('Building request: ${this.isMultipart}, url: $path');
    var request = this;
    request.interceptors.forEach((e) async {
      request = e.onRequest(request);
    });
    return request;
  }

  String get buildQuery {
    String q = '';
    query.forEach((key, value) {
      if (value != null) q += '$key=$value&';
    });
    return q;
  }

  Uri get uri {
    var url = '$baseUrl/$path';
    if (!url.contains('?')) {
      url += '?';
    } else if (!url.endsWith('&')) {
      url += '&';
    }
    url += buildQuery;
    return Uri.parse(url.normalizeUrl);
  }
}

class ErrorDescription {
  final String key;

  ErrorDescription({this.key = ''});
}

class Extra<T> {
  final String key;

  Extra(this.key);
}
