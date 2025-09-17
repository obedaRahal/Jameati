import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:project_manag_ite/core/class/status_request.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData({
    required String url,
    required Map<String, String> body,
    bool useMultipart = false,
    Map<String, String>? headers,
    Map<String, String>? files,
  }) async {
    try {
      // if (!await checkInternet()) {
      //   return const Left(StatusRequest.offlinefailure);
      // }

      http.Response response;

      if (useMultipart) {
        var uri = Uri.parse(url);
        var request = http.MultipartRequest('POST', uri);
        request.fields.addAll(body);
        if (files != null) {
          for (var entry in files.entries) {
            request.files
                .add(await http.MultipartFile.fromPath(entry.key, entry.value));
          }
        }
        if (headers != null) {
          request.headers.addAll(headers);
        }
        var streamed = await request.send();
        response = await http.Response.fromStream(streamed);
      } else {
        response = await http.post(
          Uri.parse(url),
          headers: headers ?? {"Content-Type": "application/json"},
          body: jsonEncode(body),
        );
      }

      debugPrint("✅ Status Code: ${response.statusCode}");
      debugPrint("✅ Response Body: ${response.body}");

      Map responseBody = {};

      try {
        responseBody = jsonDecode(response.body);
      } catch (e) {
        debugPrint("❌ Failed to decode JSON: $e");
        responseBody = {
          "title": "خطأ داخلي",
          "body": "حدث خطأ غير متوقع في الاستجابة",
          "status_code": response.statusCode
        };
      }

      return Right(responseBody); 
    } catch (e) {
      debugPrint("❌ Error in postData ar crud : $e");
      return const Left(StatusRequest.serverfaliure);
    }
  }

  Future<Either<StatusRequest, Map>> postDataToCreateGroup({
    required String url,
    required Map<String, dynamic> body,
    bool useMultipart = false,
    Map<String, String>? headers,
  }) async {
    try {
      http.Response response;
      if (useMultipart) {
        final uri = Uri.parse(url);
        final request = http.MultipartRequest('POST', uri);
        if (headers != null) request.headers.addAll(headers);
        for (final entry in body.entries) {
          final key = entry.key;
          final value = entry.value;
          if (value is File) {
            request.files
                .add(await http.MultipartFile.fromPath(key, value.path));
          } else if (value is List) {
            final fieldName = key.endsWith('[]') ? key : '$key[]';
            for (final v in value) {
              request.files.add(
                http.MultipartFile.fromString(fieldName, v.toString(),
                    filename: null),
              );
            }
          } else { request.fields[key] = value?.toString() ?? ''; }
        }

        final streamed = await request.send();
        response = await http.Response.fromStream(streamed);
      } else {
        response = await http.post(
          Uri.parse(url),
          headers: headers ?? {"Content-Type": "application/json"},
          body: jsonEncode(body),
        );
      }

      debugPrint("✅ Status Code: ${response.statusCode}");
      debugPrint("✅ Response Body: ${response.body}");

      Map resp = {};
      try {
        resp = jsonDecode(response.body);
      } catch (_) {
        resp = {
          "title": "خطأ داخلي",
          "body": "حدث خطأ غير متوقع في الاستجابة",
          "statusCode": response.statusCode,
        };
      }
      return Right(resp);
    } catch (e) {
      debugPrint("❌ Error in postData: $e");
      return const Left(StatusRequest.serverfaliure);
    }
  }

  Future<Either<StatusRequest, Map>> getData({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      // if (!await checkInternet()) {
      //   return const Left(StatusRequest.offlinefailure);
      // }

      final response = await http.get(
        Uri.parse(url),
        headers: headers ?? {"Content-Type": "application/json"},
      );

      debugPrint("✅ GET Status Code: ${response.statusCode}");
      debugPrint("✅ GET Response Body: ${response.body}");

      Map responseBody = {};

      try {
        responseBody = jsonDecode(response.body);
      } catch (e) {
        debugPrint("❌ Failed to decode GET JSON: $e");
        responseBody = {
          "title": "خطأ داخلي",
          "body": "حدث خطأ غير متوقع في الاستجابة",
          "status_code": response.statusCode
        };
      }

      return Right(responseBody);
    } catch (e) {
      debugPrint("❌ Error in getData at crud: $e");
      return const Left(StatusRequest.serverfaliure);
    }
  }

  // for download imgggg
  Future<Either<StatusRequest, http.Response>> getBytes({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers, 
      );

      debugPrint("✅ GET(BYTES) Status Code: ${response.statusCode}");
      debugPrint(
          "✅ GET(BYTES) Content-Type: ${response.headers['content-type']}");

      return Right(response);
    } catch (e) {
      debugPrint("❌ Error in getBytes at crud: $e");
      return const Left(StatusRequest.serverfaliure);
    }
  }

  Future<Either<StatusRequest, Map>> deleteData({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers ?? {"Content-Type": "application/json"},
        body: body != null ? jsonEncode(body) : null,
      );

      debugPrint("✅ DELETE Status Code: ${response.statusCode}");
      debugPrint("✅ DELETE Response Body: ${response.body}");

      Map resp = {};
      try {
        resp = jsonDecode(response.body);
      } catch (_) {
        resp = {
          "title": "خطأ داخلي",
          "body": "حدث خطأ غير متوقع في الاستجابة",
          "statusCode": response.statusCode,
        };
      }
      return Right(resp);
    } catch (e) {
      debugPrint("❌ Error in deleteData at crud: $e");
      return const Left(StatusRequest.serverfaliure);
    }
  }

// داخل Crud
  Future<Either<StatusRequest, Map<String, dynamic>>> getListData({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers, // لا تفرض Content-Type على GET
      );

      debugPrint("✅ GET(List) Status Code: ${response.statusCode}");
      debugPrint("✅ GET(List) Response Body: ${response.body}");

      final status = response.statusCode;

      try {
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          return Right({
            "statusCode": status,
            "data": decoded,
          });
        } else if (decoded is Map<String, dynamic>) {

          decoded["statusCode"] = status;
          return Right(decoded);
        } else {
          return Right({
            "statusCode": status,
            "data": decoded,
          });
        }
      } catch (e) {
        debugPrint("❌ Failed to decode GET(List) JSON: $e");
        return Right({
          "statusCode": response.statusCode,
          "title": "خطأ داخلي",
          "body": "حدث خطأ غير متوقع في الاستجابة",
          "raw": response.body,
        });
      }
    } catch (e) {
      debugPrint("❌ Error in getListData at crud: $e");
      return const Left(StatusRequest.serverfaliure);
    }
  }
}
