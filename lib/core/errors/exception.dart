import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  final String? message;
  ServerException({
    this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory ServerException.fromMap(Map<String, dynamic> map) {
    return ServerException(
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerException.fromJson(String source) =>
      ServerException.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CacheException implements Exception {}
