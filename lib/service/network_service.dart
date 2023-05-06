import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import '../data/configuration_data.dart';
import '../data/variable/environment_variable_data.dart';
import '../utility/dialog_utility.dart';
import '../provider/app_provider.dart';

class NetworkService {
  static Future<NetworkModelService?> get(final BuildContext context, {
    required final String apiRoute,
    final String hostAddress = '',
    final Map<String, String>? header,
    final Map<String, Object>? body,
    final void Function(Map)? errorFormHandler,
  }) async {
    final url = _configureUrl(context, hostAddress, apiRoute);

    final dataParameterList = <String>[];
    body?.forEach((key, value) {
      dataParameterList.add('$key=${Uri.encodeComponent(value.toString())}');
    });

    final parameter = dataParameterList.isEmpty ? '' : '?${dataParameterList.join('&')}';

    log('[Request][Get] Network Service: $url$parameter');

    return _handleResponse(
      context,
      requestHandler: () => http.get(
        Uri.parse('$url$parameter'),
        headers: _getHeaderConfiguration(context, header),
      ),
      logPrefix: '[Response][Get] Network Service: ',
      errorFormHandler: errorFormHandler,
    );
  }

  static Future<NetworkModelService?> put(final BuildContext context, {
    required final String apiRoute,
    final String hostAddress = '',
    final Map<String, String>? header,
    final Object? body,
    final void Function(Map)? errorFormHandler,
  }) async {
    final url = _configureUrl(context, hostAddress, apiRoute);

    log('[Request][Put] Network Service: $url : $body');

    return _handleResponse(
      context,
      requestHandler: () => http.put(
        Uri.parse(url),
        headers: _getHeaderConfiguration(context, header),
        body: body,
      ),
      logPrefix: '[Response][Put] Network Service: ',
      errorFormHandler: errorFormHandler,
    );
  }

  static Future<NetworkModelService?> post(final BuildContext context, {
    required final String apiRoute,
    final String hostAddress = '',
    final Map<String, String>? header,
    final Object? body,
    final bool enableJsonEncoder = true,
    final void Function(Map)? errorFormHandler,
  }) async {
    final url = _configureUrl(context, hostAddress, apiRoute);

    log('[Request][Post] Network Service: $url : $body');

    return _handleResponse(
      context,
      requestHandler: () => http.post(
        Uri.parse(url),
        headers: _getHeaderConfiguration(context, header),
        body: enableJsonEncoder ? jsonEncode(body) : body,
      ),
      logPrefix: '[Response][Post] Network Service: ',
      errorFormHandler: errorFormHandler,
    );
  }

  static Future<NetworkModelService?> delete(final BuildContext context, {
    required final String apiRoute,
    final String hostAddress = '',
    final Map<String, String>? header,
    final Object? body,
    final void Function(Map)? errorFormHandler,
  }) async {
    final url = _configureUrl(context, hostAddress, apiRoute);

    log('[Request][Delete] Network Service: $url : $body');

    return _handleResponse(
      context,
      requestHandler: () => http.delete(
        Uri.parse(url),
        headers: _getHeaderConfiguration(context, header),
        body: body,
      ),
      logPrefix: '[Response][Delete] Network Service: ',
      errorFormHandler: errorFormHandler,
    );
  }

  static Future<NetworkModelService?> postMultipart(final BuildContext context, {
    required final String apiRoute,
    final String hostAddress = '',
    final Map<String, String>? header,
    final dynamic body,
    final Map<String, Uint8List>? fileMap,
    final String fileType = 'file',
    final MapEntry<String, String>? mediaTypeMapEntry,
    final void Function(Map)? errorFormHandler,
  }) {
    final url = _configureUrl(context, hostAddress, apiRoute);

    log('[Request][Post Multipart] Network Service: $url : $body');

    return _handleResponse(
      context,
      requestHandler: () async {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse(url),
        );

        header?.forEach((key, value) {
          request.headers[key] = value;
        });

        body?.forEach((key, value) {
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

        return http.Response.fromStream(await request.send());
      },
      logPrefix: '[Response][Post Multipart] Network Service: ',
      errorFormHandler: errorFormHandler,
    );
  }

  static String _configureUrl(final BuildContext context, final String hostAddress,final String apiRoute,) {
    final String urlHostAddress;

    if (hostAddress.trim().isEmpty) {
      if (ConfigurationData.isTestMode) {
        switch(AppProvider.of(context).environment) {
          case EnvironmentVariableData.production:
            urlHostAddress = ConfigurationData.hostAddressProduction;
            break;
          case EnvironmentVariableData.userAcceptanceTest:
            urlHostAddress = ConfigurationData.hostAddressUserAcceptanceTest;
            break;
          case EnvironmentVariableData.systemIntegrationTest:
            urlHostAddress = ConfigurationData.hostAddressSystemIntegrationTest;
            break;
          case EnvironmentVariableData.development:
          default:
            urlHostAddress = ConfigurationData.hostAddressDevelopment;
        }
      } else {
        urlHostAddress = ConfigurationData.hostAddressProduction;
      }
    } else {
      urlHostAddress = hostAddress;
    }

    return '$urlHostAddress/$apiRoute';
  }

  static Map<String, String> _getHeaderConfiguration(final BuildContext context, final Map<String, String>? additionalHeader) {
    return {
      'authorization': AppProvider.of(context).accessToken,
      ...?additionalHeader,
    };
  }

  static Future<NetworkModelService?> _handleResponse(final BuildContext context, {
    required final Future<http.Response> Function() requestHandler,
    required final String logPrefix,
    final void Function(Map)? errorFormHandler,
  }) async {
    try {
      final response = await requestHandler();

      final statusCode = response.statusCode;

      if (statusCode > 199 && statusCode < 300) {
        return NetworkModelService(
          statusCode: response.statusCode,
          responseString: response.body,
          responseByteList: response.bodyBytes,
        );
      } else if (context.mounted) {
        final String title;
        final String message;
        if (response.body.contains('https')) {
          title = 'API Web Error';
          message = response.body;
        } else {
          final errorMap = jsonDecode(response.body)?['error'];

          title = errorMap?['title']?.toString() ?? 'Error ${response.statusCode}';
          message = errorMap?['message']?.toString() ?? 'Something unexpected happened. Please try again.';

          final formErrorMap = errorMap?['form'];

          if (formErrorMap != null) {
            errorFormHandler?.call(formErrorMap);
          }
        }

        await DialogUtility.showAlert(
          context,
          title: title,
          message: message,
          color: AppProvider.of(context).color.error,
          onColor: AppProvider.of(context).color.onError,
        );
      }
    } on SocketException {
      const message = 'Could not connect to server. Please check your internet connection.';

      log(message);

      await DialogUtility.showAlert(
        context,
        title: 'Network Error',
        message: message,
        color: AppProvider.of(context).color.error,
        onColor: AppProvider.of(context).color.onError,
      );
    } on TimeoutException {
      const message = 'Connection timed out. Please try again later.';

      log(message);

      await DialogUtility.showAlert(
        context,
        title: 'Request Timeout',
        message: message,
        color: AppProvider.of(context).color.error,
        onColor: AppProvider.of(context).color.onError,
      );
    } on Exception catch (e) {
      final message = 'Something Unexpected Happened. $e';

      log(message);

      await DialogUtility.showAlert(
        context,
        title: 'Unexpected Error',
        message: message,
        color: AppProvider.of(context).color.error,
        onColor: AppProvider.of(context).color.onError,
      );
    }

    return null;
  }

  const NetworkService._();
}

class NetworkModelService {
  final int statusCode;
  final String responseString;
  final Uint8List? responseByteList;

  const NetworkModelService({
    required this.statusCode,
    required this.responseString,
    this.responseByteList,
  });

  Map get responseMap {
    return jsonDecode(responseString);
  }
}
