import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shortest_path/domain/core/services/shortest_path_searcher.dart';
import 'package:flutter_shortest_path/domain/core/storage/local_storage.dart';
import 'package:flutter_shortest_path/domain/execution/result_item.dart';
import 'package:flutter_shortest_path/domain/start/path_item.dart';
import 'package:flutter_shortest_path/infrastructure/core/api/endpoints_config.dart';
import 'package:flutter_shortest_path/infrastructure/execution/dto/send_resulting_data_dto.dart';
import 'package:flutter_shortest_path/infrastructure/execution/execution_facade.dart';
import 'package:flutter_shortest_path/infrastructure/start/url_facade.dart';
import 'package:flutter_shortest_path/injection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

part 'execution_process_event.dart';
part 'execution_process_state.dart';

class ExecutionProcessBloc
    extends Bloc<ExecutionProcessEvent, ExecutionProcessState> {
  ExecutionProcessBloc() : super(ExecutionProcessState.initial()) {
    on<UrlChanged>((event, emit) {
      emit(state.copyWith(
        url: event.url,
      ));
    });
    on<NavigatedToProcessing>((event, emit) {
      emit(state.copyWith(
        hasNavigateToProcessing: true,
      ));
    });

    on<ObtainDataAndStartProcessing>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        hasNavigateToProcessing: false,
      ));

      if (state.url != APIConfig.URL + APIConfig.obtainProcessingData) {
        Logger().e('Incorrect! You should pass correct URL!');
        emit(state.copyWith(
          isLoading: false,
        ));

        Fluttertoast.showToast(
          msg: 'Incorrect! You should pass correct URL!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        return;
      }

      // saving url in local storage
      await getIt<ILocalStorage>().saveBaseUrl(state.url);

      var response = await getIt<IUrlFacade>().obtainData();

      if (response.error == true) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: response.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Logger().e(response.message);
        return;
      }

      emit(state.copyWith(
        items: response.data,
        isProcessing: true,
        percentageProgress: 0,
      ));

      int totalItems = response.data.length;

      try {
        for (var i = 0; i < totalItems; i++) {
          ResultItem? resultItem =
              ShortestPathService().findShortestPath(response.data[i]);

          if (resultItem == null) {
            Logger().e('Path not found');
          } else {
            emit(state.copyWith(
              resultItems: [...state.resultItems, resultItem],
              percentageProgress: (i + 1) / totalItems,
            ));
          }

          // !!! FAKE DELAY FOR DEMO
          await Future.delayed(const Duration(milliseconds: 200));
        }
      } catch (e) {
        Logger().e(e);
      }

      emit(state.copyWith(
        isLoading: false,
        isProcessing: false,
      ));
    });
    on<SendResults>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      var response = await getIt<IExecutionFacade>()
          .sendData(SendResultingDataRequest(state.resultItems));

      if (response.error == true) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: response.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Logger().e(response.message);
        return;
      }

      emit(state.copyWith(
        isLoading: false,
        isProcessing: false,
        isResultSent: true,
      ));
    });
  }
}
