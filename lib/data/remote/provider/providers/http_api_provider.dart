// import "dart:async";
// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';

// import '../../file_field.dart';
// import '../api_methods.dart';
// import '../api_provider.dart';
// import '../api_request.dart';
// import '../api_response.dart';

// class HttpApiProvider extends ApiProvider {
//   @override
//   Future<ApiResponse<ResultType, InnerType>> send<ResultType, InnerType>(
//       ApiRequest<ResultType, InnerType> request) async {
//     request = request.build;

//     http.Response response;
//     print('handling request ${request.isMultipart}');
//     try {
//       if (request.isMultipart) {
//         var res = await handleMultipart(request);
//         return ApiResponse<ResultType, InnerType>(
//                 request: request,
//                 bodyString: await res.stream.bytesToString(),
//                 headers: res.headers,
//                 statusCode: res.statusCode)
//             .resolve;
//       }
//       response = await runRequest(request)
//           .timeout(Duration(seconds: request.timeout), onTimeout: () {
//         throw (TimeoutException('Connection timed out'));
//       });
//     } catch (e) {
//       if (kDebugMode) print(' error in request ');
//       if (kDebugMode) print(e.toString());
//       if (kDebugMode) print(e.runtimeType);
//       return ApiResponse<ResultType, InnerType>(
//               request: request,
//               headers: {},
//               statusCode: 400,
//               error: formatErrorMessage(e))
//           .resolve;
//     }

//     // print(response?.bodyBytes);

//     return ApiResponse<ResultType, InnerType>(
//             request: request,
//             bodyString: response.body,
//             headers: response.headers,
//             statusCode: response.statusCode)
//         .resolve;
//   }

//   Future<http.Response> runRequest(ApiRequest request) {
//     var uri = request.uri;
//     if (kDebugMode) print(uri.data?.toString());
//     switch (request.method) {
//       case ApiMethods.delete:
//         return http.delete(uri, headers: request.headers);
//       case ApiMethods.post:
//         return http.post(uri,
//             headers: request.headers, body: jsonEncode(request.body));
//       case ApiMethods.put:
//         return http.put(uri,
//             headers: request.headers, body: jsonEncode(request.body));
//       default:
//         return http.get(uri, headers: request.headers);
//     }
//   }

//   Future<http.StreamedResponse> handleMultipart(ApiRequest request) {
//     var uri = request.uri;
//     if (kDebugMode) print(uri.data?.toString());
//     http.MultipartRequest req = http.MultipartRequest(
//       request.method ?? ApiMethods.get,
//       uri,
//     );

//     request.body?.forEach((key, value) async {
//       if (value is FileFormField) {
//         req.files.add(await http.MultipartFile.fromPath(key, value.path));
//       } else {
//         req.fields[key] = value;
//       }
//     });
//     request.headers.forEach((key, value) {
//       req.headers[key] = value;
//     });
//     return req.send();
//   }
// }
