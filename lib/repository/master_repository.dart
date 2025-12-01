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
}
