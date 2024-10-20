import 'package:flutter_shortest_path/domain/execution/result_item.dart';
import 'package:flutter_shortest_path/infrastructure/core/dto/base_response.dart';
import 'package:flutter_shortest_path/infrastructure/core/dto/json_serializable.dart';

class SendResultingDataDto with JsonSerializable<SendResultingDataDto> {
  final String id;
  final bool correct;

  SendResultingDataDto(this.id, this.correct);

  factory SendResultingDataDto.fromJson(Map<String, dynamic> json) {
    return SendResultingDataDto(json['id'], json['correct']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'correct': correct,
    };
  }
}

class SendResultingDataRequest {
  final List<ResultItem> items;

  SendResultingDataRequest(this.items);

  List<Map<String, dynamic>> toJson() {
    return items.map((item) => item.toJson()).toList();
  }
}

class SendResultingDataResponse extends BaseResponse
    with JsonSerializable<SendResultingDataResponse> {
  final List<SendResultingDataDto>? data;

  SendResultingDataResponse({
    required super.error,
    required super.message,
    required this.data,
  });

  factory SendResultingDataResponse.fromJson(Map<String, dynamic> json) {
    List<SendResultingDataDto>? parsedData;

    if (json['data'] is List) {
      parsedData = json['data']
          .map((item) =>
              SendResultingDataDto.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (json['data'] is Map<String, dynamic>) {
      parsedData = null;
    }

    return SendResultingDataResponse(
      error: json['error'],
      message: json['message'],
      data: parsedData,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
