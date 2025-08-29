import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class HttpHelper {
  // عدّل الـ IP حسب شبكتك
  static const String _baseUrl = 'http://192.168.1.6:5200/api';

  static Map<String, String> getHeaders() {
    final token = GetStorage().read('token') ?? '';
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      // ملاحظة: GET عادةً ما يحتاج Content-Type فقط إذا في body، بس خليه آمن
      'Content-Type': 'application/json',
    };
  }

  /// GET مع دعم Query Parameters
  static Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? query}) async {
    final uri = Uri.parse('$_baseUrl/$endpoint').replace(
      queryParameters: query?.map((k, v) => MapEntry(k, '$v')),
    );

    final response = await http.get(uri, headers: getHeaders());
    // Debug
    print('GET $uri -> ${response.statusCode}');
    print('Body: ${response.body}');
    return _handleResponse(response);
  }

  static Future<dynamic> post(String endpoint, dynamic data,
      {Map<String, dynamic>? query}) async {
    final uri = Uri.parse('$_baseUrl/$endpoint').replace(
      queryParameters: query?.map((k, v) => MapEntry(k, '$v')),
    );
    try {
      final response = await http.post(
        uri,
        headers: getHeaders(),
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e, s) {
      log('POST error: $e\n$s');
      rethrow; // مهم: لا ترجع null، خلّي الخطأ يطلع للي فوق
    }
  }

  static Future<dynamic> put(String endpoint, dynamic data,
      {Map<String, dynamic>? query}) async {
    final uri = Uri.parse('$_baseUrl/$endpoint').replace(
      queryParameters: query?.map((k, v) => MapEntry(k, '$v')),
    );
    final response =
        await http.put(uri, headers: getHeaders(), body: json.encode(data));
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint,
      {Map<String, dynamic>? query}) async {
    final uri = Uri.parse('$_baseUrl/$endpoint').replace(
      queryParameters: query?.map((k, v) => MapEntry(k, '$v')),
    );
    final response = await http.delete(uri, headers: getHeaders());
    return _handleResponse(response);
  }

  static Future<dynamic> postMultipart(
    String endpoint,
    Map<String, String> fields,
    File? file, {
    String fileFieldName = 'icon',
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$_baseUrl/$endpoint').replace(
      queryParameters: query?.map((k, v) => MapEntry(k, '$v')),
    );
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

  /// لا تلفّ رسالة السيرفر داخل Exception نصي وتضيعها.
  /// إذا الرد فشل و JSON فيه { message: ... } ارمي الـ Map نفسه.
  /// إذا مو JSON، ارمي الـ body كنص.
  static dynamic _handleResponse(http.Response response) {
    final status = response.statusCode;
    final bodyText = response.body;

    if (bodyText.isEmpty) {
      // ممكن تكون عمليات بدون body
      if (status >= 200 && status < 300) return null;
      throw 'HTTP $status';
    }

    dynamic data;
    try {
      data = json.decode(bodyText);
    } catch (_) {
      // مو JSON صالح
      if (status >= 200 && status < 300) return bodyText;
      throw bodyText; // اسمح للطبقات فوق تقراه كنص
    }

    if (status >= 200 && status < 300) {
      return data;
    } else {
      // إذا السيرفر رجّع { message: '...' } خلّيها تطلع كما هي Map
      if (data is Map<String, dynamic>) {
        throw data; // بيفيد _extractServerMessage
      }
      // غير ذلك: ارمي النص المحض
      throw bodyText;
    }
  }
}
