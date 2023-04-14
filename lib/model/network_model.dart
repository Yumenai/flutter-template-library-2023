import 'dart:convert';

class NetworkModel {
  final int statusCode;
  final String response;

  const NetworkModel({
    required this.statusCode,
    required this.response,
  });

  Map get responseMap {
    return jsonDecode(response);
  }
}
