import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

// typedef Json = Map<String, dynamic>;

class HttpHelper {
  static const String _baseUrl = 'http://192.168.1.4:5200/api';

  static Map<String, String> getHeaders() {
    final token = GetStorage().read('token') ?? '';
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        ...getHeaders(),
        'Content-Type': 'application/json',
      },
    );
    return _handleResponse(response);
  }

  static Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          ...getHeaders(),
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e, s) {
      log('POST error: $e\n$s');
      return null;
    }
  }

  static Future<dynamic> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        ...getHeaders(),
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        ...getHeaders(),
        'Content-Type': 'application/json',
      },
    );
    return _handleResponse(response);
  }

  static Future<dynamic> postMultipart(
    String endpoint,
    Map<String, String> fields,
    File? file, {
    String fileFieldName = 'icon',
  }) async {
    final uri = Uri.parse('$_baseUrl/$endpoint');
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll(getHeaders());

    request.fields.addAll(fields);

    if (file != null) {
      final fileStream = http.MultipartFile.fromBytes(
        fileFieldName,
        await file.readAsBytes(),
        filename: file.path.split('/').last,
      );
      request.files.add(fileStream);
    }

    log('Uploading file to $uri with fields: $fields');

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    try {
      if (response.body.isEmpty) {
        // إذا ما في أي بيانات، رجع success فاضي
        return null;
      }

      final data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Unexpected error occurred');
      }
    } catch (e) {
      throw Exception('Invalid response format or error: $e');
    }
  }
}
