import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class NetworkUtility {
  static bool isSuccess(final http.Response? response) {
    final statusCode = response?.statusCode ?? -999;

    return statusCode >= 200 && statusCode < 300;
  }

  static bool isFailure(final http.Response? response) {
    return isSuccess(response);
  }

  static bool isConnectionError(final http.Response? response) {
    return response == null;
  }

  static Future<http.Response?> get({
    required final String hostAddress,
    required final String apiRoute,
    final Map<String, String>? headerMap,
    final Map<String, Object>? bodyMap,
  }) async {
    final url = '$hostAddress/$apiRoute';

    final dataParameterList = <String>[];
    bodyMap?.forEach((key, value) {
      dataParameterList.add('$key=${Uri.encodeComponent(value.toString())}');
    });

    final parameter = dataParameterList.isEmpty ? '' : '?${dataParameterList.join('&')}';

    log('[Request][Get] Network Utility: $url$parameter');

    try {
      final response = await http.get(
        Uri.parse('$url$parameter'),
        headers: headerMap,
      );

      log('[Success][Get] Network Utility: $url : ${response.statusCode} : ${response.body}');

      return response;
    } catch (error) {
      log('[Error][Get] Network Utility: $url : $error');
      return null;
    }
  }

  static Future<http.Response?> put({
    required final String hostAddress,
    required final String apiRoute,
    final Map<String, String>? headerMap,
    final Object? bodyObject,
  }) async {
    final url = '$hostAddress/$apiRoute';

    log('[Request][Put] Network Utility: $url : $bodyObject');

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headerMap,
        body: bodyObject,
      );

      log('[Success][Put] Network Utility: $url : ${response.statusCode} : ${response.body}');

      return response;
    } catch (error) {
      log('[Error][Put] Network Utility: $url : $error');
      return null;
    }
  }

  static Future<http.Response?> post({
    required final String hostAddress,
    required final String apiRoute,
    final Map<String, String>? headerMap,
    final Object? bodyObject,
    final bool enableJsonEncoder = true,
  }) async {
    final url = '$hostAddress/$apiRoute';

    log('[Request][Post] Network Utility: $url : $bodyObject');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headerMap,
        body: enableJsonEncoder ? jsonEncode(bodyObject) : bodyObject,
      );

      log('[Success][Post] Network Utility: $url : ${response.statusCode} : ${response.body}');

      return response;
    } catch (error) {
      log('[Error][Post] Network Utility: $url : $error');
      return null;
    }
  }

  static Future<http.Response?> delete({
    required final String hostAddress,
    required final String apiRoute,
    final Map<String, String>? headerMap,
    final Object? bodyObject,
  }) async {
    final url = '$hostAddress/$apiRoute';

    log('[Request][Delete] Network Utility: $url : $bodyObject');

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headerMap,
        body: bodyObject,
      );

      log('[Success][Delete] Network Utility: $url : ${response.statusCode} : ${response.body}');

      return response;
    } catch (error) {
      log('[Error][Delete] Network Utility: $url : $error');
      return null;
    }
  }


  static Future<http.Response?> postMultipart({
    required final String hostAddress,
    required final String apiRoute,
    final Map<String, String>? headerMap,
    final dynamic bodyObject,
    final Map<String, Uint8List>? fileMap,
    final String fileType = 'file',
    final MapEntry<String, String>? mediaTypeMapEntry,
  }) async {
    final url = '$hostAddress/$apiRoute';

    log('[Request][Post Multipart] Network Utility: $url : $bodyObject');

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      headerMap?.forEach((key, value) {
        request.headers[key] = value;
      });

      bodyObject?.forEach((key, value) {
        request.fields[key] = value;
      });

      fileMap?.forEach((key, value) {
        request.files.add(http.MultipartFile.fromBytes(
          fileType,
          value,
          filename: key,
          contentType: mediaTypeMapEntry == null ? null : MediaType(mediaTypeMapEntry.key, mediaTypeMapEntry.value),
        ));
      });

      final response = await http.Response.fromStream(await request.send());

      log('[Success][Post Multipart] Network Utility: $url : ${response.statusCode} : ${response.body}');

      return response;
    } catch (error) {
      log('[Error][Post Multipart] Network Utility: $url : $error');
      return null;
    }
  }

  const NetworkUtility._();
}
