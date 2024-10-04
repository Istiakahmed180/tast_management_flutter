import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_response.dart';

class NetworkService {
  // Common request timeout duration
  static const Duration timeoutDuration = Duration(seconds: 15);

  // Get Token from SharedPreferences
  static Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_token");
  }

  // Create Headers
  static Map<String, String> _createHeaders(String? token) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Get API Network Service
  static Future<NetworkResponse> getRequest({required String url}) async {
    final String? token = await _getToken();
    try {
      Uri uri = Uri.parse(url);
      final response = await get(uri, headers: _createHeaders(token!))
          .timeout(timeoutDuration);
      return _handleResponse(url, response, token);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Post API Network Service
  static Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic> requestBody,
  }) async {
    final String? token = await _getToken();
    try {
      Uri uri = Uri.parse(url);
      final response = await post(
        uri,
        headers: _createHeaders(token!),
        body: jsonEncode(requestBody),
      ).timeout(timeoutDuration);
      return _handleResponse(url, response, token);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Common function to handle API responses
  static NetworkResponse _handleResponse(
      String url, Response response, String token) {
    printResponse(url, response, token);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final jsonResponse = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          requestResponse: jsonResponse,
        );
      } catch (e) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: "Invalid JSON format: ${e.toString()}",
        );
      }
    } else {
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: "Request failed with status: ${response.statusCode}",
      );
    }
  }

  // Common function to handle errors
  static NetworkResponse _handleError(dynamic error) {
    return NetworkResponse(
      isSuccess: false,
      statusCode: -1,
      errorMessage: error is TimeoutException
          ? "Request timed out after ${timeoutDuration.inSeconds} seconds. Please check your connection and try again."
          : "An error occurred: ${error.toString()}",
    );
  }

  // Logging the API responses for debugging
  static void printResponse(String url, Response response, String token) {
    debugPrint(
        "URL : $url\nResponse Code : ${response.statusCode}\nToken : $token\nResponse Body : ${response.body}");
  }
}
