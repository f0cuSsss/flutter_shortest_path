import 'package:flutter_shortest_path/infrastructure/core/api/dio_config.dart';
import 'package:flutter_shortest_path/infrastructure/core/api/endpoints_config.dart';
import 'package:flutter_shortest_path/infrastructure/start/dto/obtain_data_dto.dart';
import 'package:flutter_shortest_path/injection.dart';
import 'package:logger/logger.dart';

abstract class IUrlFacade {
  Future<ObtainDataResponse> obtainData();
}

class UrlFacade extends IUrlFacade {
  @override
  Future<ObtainDataResponse> obtainData() async {
    try {
      var response = await getIt<DioConfig>().dio.get(
            APIConfig.URL + APIConfig.obtainProcessingData,
          );

      Logger().d(response.data);

      var data = ObtainDataResponse.fromJson(response.data);

      return data;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }
}
