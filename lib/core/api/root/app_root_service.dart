import 'package:dio/dio.dart';

import '../../log/loggers.dart';
import '../constants/api_constants.dart';
import '../endpoints/api_url_manager.dart';
import '../exceptions/root_exception.dart'; // Import the response processor
import '../response/root_response.dart';

class AppRootService {
  static const String TAG = '[AppRootService]';
  final Dio dio;
  final Map<String, CacheEntry> _cache = {};

  AppRootService({required this.dio}) {
    _initializeDio();
  }

  void _initializeDio() {
    dio.options.baseUrl = AppUrls.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.options.sendTimeout = const Duration(seconds: 60);

    dio.options.headers = {
      'Content-Type': 'application/json',
      'api_key': ApiConstants.apiKey,
    };

    // Request Interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        AppLogger.logInfo(
            '$TAG: REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        AppLogger.logInfo(
            '$TAG: RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (error, handler) {
        AppLogger.logError(
            '$TAG: ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
        return handler.next(error);
      },
    ));
  }

  Future<dynamic> sendRestRequest({
    required String endpoint,
    required String method,
    Map<String, dynamic>? queryParams,
    dynamic body,
    bool useCache = true,
  }) async {
    try {
      //TODO: Log before service call
          AppLogger.logInfo('$TAG Request:\nEndpoint: $endpoint\nMethod: $method\nParams: $queryParams\nBody: $body');


      // Check cache for GET requests
      // if (method == 'GET' && useCache) {
      //   final cachedResponse = _getCachedResponse(endpoint, queryParams);
      //   if (cachedResponse != null) {
      //     AppLogger.logInfo('$TAG: Returning cached response for $endpoint');
      //     return cachedResponse;
      //   }
      // }

      // Handle request with retry logic for network issues
      Response response = await _executeWithRetry(
        () => dio.request(
          endpoint,
          options: Options(method: method),
          queryParameters: method == 'GET' ? queryParams : null,
          data: method != 'GET' ? body : null,
        ),
      );

      // Cache successful GET responses
      // if (method == 'GET' && useCache) {
      //   _cacheResponse(endpoint, queryParams, response.data);
      // }

      //TODO: Log after service call
         AppLogger.logInfo('$TAG Response:\nStatus: ${response.statusCode}\nData: ${response.data}');

      // Process and return the response
      return RootResponse.processResponse(response);
    } on DioException catch (e) {
      throw RootException.fromDioError(e);
    } catch (e) {
      //TODO: Log error call
         AppLogger.logError('$TAG Error:\n$e');

      throw RootException(message: 'Unexpected error occurred: $e');
    }
  }

  Future<T> _executeWithRetry<T>(Future<T> Function() operation) async {
    const maxAttempts = 3;
    const retryDelay = Duration(seconds: 1);

    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await operation();
      } catch (e) {
        if (e is DioException &&
            (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout ||
                e.type == DioExceptionType.sendTimeout) &&
            attempt < maxAttempts) {
          AppLogger.logWarning(
              '$TAG: Retry attempt $attempt after network error');
          await Future.delayed(retryDelay * attempt);
          continue;
        }
        rethrow;
      }
    }
    throw RootException(message: 'Max retry attempts reached');
  }

  dynamic _getCachedResponse(String endpoint, Map<String, dynamic>? params) {
    final key = _getCacheKey(endpoint, params);
    final cachedEntry = _cache[key];
    if (cachedEntry != null && !cachedEntry.isExpired) {
      return cachedEntry.data;
    }
    return null;
  }

  void _cacheResponse(
      String endpoint, Map<String, dynamic>? params, dynamic data) {
    final key = _getCacheKey(endpoint, params);
    _cache[key] = CacheEntry(
      data: data,
      timestamp: DateTime.now(),
    );
  }

  String _getCacheKey(String endpoint, Map<String, dynamic>? params) {
    return '$endpoint${params?.toString() ?? ''}';
  }
}

class CacheEntry {
  final dynamic data;
  final DateTime timestamp;

  CacheEntry({required this.data, required this.timestamp});

  bool get isExpired =>
      DateTime.now().difference(timestamp) > ApiConstants.CACHE_DURATION;
}
//
// // 1. Base API Service
// class AppRootService {
//   static const String TAG = '[AppApiService]';
//   final Dio dio;
//
//   // 2. Constructor to initialize Dio instance and set up default configurations
//   AppRootService({required this.dio}) {
//     _initializeDio();
//   }
//
//   // 3. Configure Dio instance with base options (timeout, headers, etc.)
//   void _initializeDio() {
//     dio.options.baseUrl = AppUrls.baseUrl;
//     dio.options.connectTimeout = const Duration(seconds: 60);
//     dio.options.receiveTimeout = const Duration(seconds: 60);
//     dio.options.sendTimeout = const Duration(seconds: 60);
//
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'api_key': ApiConstants.apiKey,
//     };
//   }
//
//   // 4. Method to send REST API requests using Dio
//   Future<dynamic> sendRestRequest({
//     required String endpoint,
//     required String method,
//     Map<String, dynamic>? queryParams,
//     dynamic body,
//   }) async {
//     try {
//       // Logging request details
//       AppLogger.logInfo('$TAG: Sending $method request to $endpoint');
//       AppLogger.logDebug('$TAG: Query params: $queryParams');
//       AppLogger.logDebug('$TAG: Body: $body');
//
//       // 5. Send request based on the HTTP method
//       final response = await dio.request(
//         endpoint,
//         options: Options(method: method),
//         queryParameters: method == 'GET' ? queryParams : null,
//         data: method != 'GET' ? body : null,
//       );
//       printMessage("1. $TAG Response: $response");
//       // 6. Use ApiResponseProcessor to handle and process the response
//       return RootResponse.processResponse(response);
//     } on DioException catch (e) {
//       // 7. Use ApiException.fromDioError to convert Dio error to ApiException directly
//       throw RootException.fromDioError(e);
//     } catch (e) {
//       // 8. Handle any unexpected errors
//       AppLogger.logError('$TAG: Unexpected error: $e');
//       throw RootException(message: 'Unexpected error occurred: $e');
//     }
//   }
// }
