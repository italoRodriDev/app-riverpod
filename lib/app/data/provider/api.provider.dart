import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio;

  ApiProvider({String? baseUrl, Map<String, dynamic>? headers})
      : dio = Dio(BaseOptions(
            baseUrl: baseUrl ?? 'http://api.com',
            headers: headers ??
                {
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                }));

  // -> GET
  Future<Response> get(
    String route, {
    Map<String, dynamic>? params,
  }) async {
    return await dio.get(route, queryParameters: params);
  }

  // -> POST
  Future<Response> post(String route,
      {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    return await dio.post(route, data: body, queryParameters: params);
  }

  // -> PUT
  Future<Response> put(String route,
      {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    return await dio.post(route, data: body, queryParameters: params);
  }

  // -> PATCH
  Future<Response> patch(
    String router,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  ) async {
    return await dio.patch(router, data: body, queryParameters: params);
  }

  // -> DELETE
  Future<Response> delete(String route,
      {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    return await dio.delete(route, data: body, queryParameters: params);
  }
}
