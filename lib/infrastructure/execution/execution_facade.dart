import 'package:flutter_shortest_path/infrastructure/core/api/dio_config.dart';
import 'package:flutter_shortest_path/infrastructure/core/api/endpoints_config.dart';
import 'package:flutter_shortest_path/injection.dart';
import 'package:logger/logger.dart';

import 'dto/send_resulting_data_dto.dart';

abstract class IExecutionFacade {
  Future<SendResultingDataResponse> sendData(SendResultingDataRequest request);
}

class ExecutionFacade extends IExecutionFacade {
  @override
  Future<SendResultingDataResponse> sendData(
    SendResultingDataRequest request,
  ) async {
    try {
      var response = await getIt<DioConfig>().dio.post(
            APIConfig.URL + APIConfig.sendResultingData,
            data: request.toJson(),
          );

      var data = SendResultingDataResponse.fromJson(response.data);

      return data;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }
}
