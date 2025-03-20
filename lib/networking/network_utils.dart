import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shack15_web_view_demo/user_agent.dart';

// Abstract API Repository
abstract class AbstractApiRepository {
  Future<String> getSessionToken();
  Future<Map<String, dynamic>> getAuthenticationUser(
      {required String sessionToken,
      required String mobileNumber,
      required String userName});
  factory AbstractApiRepository.getInstance() => _NetworkApiService();
}

class _NetworkApiService implements AbstractApiRepository {
  final Dio dio = Dio();
  String userAgent = 'Unknown';
  Map<String, String> commonHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    'application-name': 'WMA.Web',
    'app-version': "3.3.22",
    'x-feature-access': 'true',
  };

  @override
  Future<String> getSessionToken() async {
    userAgent = await getUserAgent();
    Map<String, String> sessionHeader = {
      HttpHeaders.userAgentHeader: userAgent,
    };
    String timeZone;
    try {
      timeZone = await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      timeZone = "Asia/Calcutta";
    }
    commonHeaders.addAll(sessionHeader);
    commonHeaders.putIfAbsent('time-zone', () => timeZone);

    try {
      final response = await dio.get(
        'https://qa03.as1.dev.bakeit360.com/unified/user-account-microservice/api/Sessions',
        options: Options(
          method: 'GET',
          contentType: 'application/json',
          headers: commonHeaders,
        ),
      );
      return response.headers['token']?.first ?? '';
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException) {
          String errorStr = e.error.toString();
          if (errorStr.contains("Failed host lookup")) {
            throw Exception(
                "Network error: Failed host lookup. Check host URL or connectivity.");
          }
          throw Exception("Network error: ${e.error}");
        }
        throw Exception("Failed to fetch session token: ${e.message}");
      }
      throw Exception("Failed to fetch session token: $e");
    }
  }

  @override
  Future<Map<String, dynamic>> getAuthenticationUser({
    required String sessionToken,
    required String mobileNumber,
    required String userName,
  }) async {
    commonHeaders.putIfAbsent('authorization', () => 'Bearer $sessionToken');
    try {
      final response = await dio.post(
        'https://qa03.as1.dev.bakeit360.com/unified/user-account-microservice/api/Shack15/Accounts/userAuth',
        data: {
          "mobileNumber": mobileNumber,
          "firstName": userName,
          "countryCode": "+91",
        },
        options: Options(
          method: 'POST',
          contentType: 'application/json',
          headers: commonHeaders,
        ),
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      if (e is DioError) {
        throw Exception("Failed to fetch session token: $e");
      }
      throw Exception("Unexpected error: $e");
    }
  }
}
