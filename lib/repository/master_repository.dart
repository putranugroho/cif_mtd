import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MasterRepository {
  static Future<dynamic> kategori(String url,
      {int? page, int? limit, String? search}) async {
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    try {
      if (kDebugMode) {
        print("ENDPOINT URL : $url");
      }

      final response = await dio.get(
        url,
        queryParameters: {
          "search": search,
          "page": page,
          "limit": limit,
        },
      );

      if (kDebugMode) {
        print("RESPONSE STATUS CODE : ${response.statusCode}");
      }

      return jsonDecode(jsonEncode(response.data));
    } on DioException catch (e) {
      // Tangani error status code
      if (e.response?.statusCode == 401) {
        return {"error": true, "status_code": 401, "message": "Unauthorized"};
      }

      // error lainnya
      return {
        "error": true,
        "status_code": e.response?.statusCode,
        "message": e.message,
      };
    }
  }

  static Future<dynamic> addkategori(
      String url, Map<String, dynamic> body) async {
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    try {
      if (kDebugMode) {
        print("ENDPOINT URL : $url");
      }

      final response = await dio.post(url, data: body);

      if (kDebugMode) {
        print("RESPONSE STATUS CODE : ${response.statusCode}");
      }

      return jsonDecode(jsonEncode(response.data));
    } on DioException catch (e) {
      print("ERROR STATUS: ${e.response?.statusCode}");
      print("ERROR DATA: ${e.response?.data}");

      // ⬇⬇ IF SERVER KIRIM 422 + PESAN ERROR → RETURN DATA-NYA
      if (e.response != null) {
        return e.response!.data;
      }

      // kalau memang tidak ada response, baru lempar ulang
      rethrow;
    }
  }

  static Future<dynamic> updatekategori(
      String url, Map<String, dynamic> body) async {
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    try {
      if (kDebugMode) {
        print("ENDPOINT URL : $url");
      }

      final response = await dio.put(url, data: body);

      if (kDebugMode) {
        print("RESPONSE STATUS CODE : ${response.statusCode}");
      }

      return jsonDecode(jsonEncode(response.data));
    } on DioException catch (e) {
      print("ERROR STATUS: ${e.response?.statusCode}");
      print("ERROR DATA: ${e.response?.data}");

      // ⬇⬇ IF SERVER KIRIM 422 + PESAN ERROR → RETURN DATA-NYA
      if (e.response != null) {
        return e.response!.data;
      }

      // kalau memang tidak ada response, baru lempar ulang
      rethrow;
    }
  }
}
