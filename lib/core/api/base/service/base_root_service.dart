// lib/core/base/base_root_service.dart
import 'package:dio/dio.dart';

abstract class BaseRootService {
  final Dio dio;

  BaseRootService(this.dio) {
    _initializeDio();
  }

  void _initializeDio() {
    dio.options
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30)
      ..validateStatus = (status) => status! < 500;
  }

  Future<T?> get<T>(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParams);
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<T?> post<T>(String path, {dynamic data}) async {
    try {
      final response = await dio.post(path, data: data);
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  T? _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      return response.data as T;
    }
    throw Exception('Request failed: ${response.statusCode}');
  }

  Exception _handleError(DioException error) {
    return Exception(error.message);
  }
}