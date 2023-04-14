import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:friflex_intro/util/helper.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkInitial()) {
    on<NetworkEvent>(
      (event, emit) async {
        final connectivityResult = await Connectivity().checkConnectivity(); // тоже async, поэтому тоже не смогли бы сразу давать ответ по интернету
        if (connectivityResult == ConnectivityResult.none) {
          emit(NetworkFailure(key: Helper.getRandomIntKey()));
        } else {
          emit(NetworkSuccess(key: Helper.getRandomIntKey()));
        } // тут пригодились ключи для сравнения состояний с предыдущими
      },
    );
  }
}
// разрешение пользоваться интернетом поставил под андроид