import 'package:flutter_shortest_path/domain/start/path_item.dart';
import 'package:flutter_shortest_path/infrastructure/core/dto/base_response.dart';
import 'package:flutter_shortest_path/infrastructure/core/dto/json_serializable.dart';

class ObtainDataResponse extends BaseResponse
    with JsonSerializable<ObtainDataResponse> {
  final List<PathItem> data;

  ObtainDataResponse({
    required super.error,
    required super.message,
    required this.data,
  });

  @override
  factory ObtainDataResponse.fromJson(Map<String, dynamic> json) {
    return ObtainDataResponse(
      error: json['error'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => PathItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
