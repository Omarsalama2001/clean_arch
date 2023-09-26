import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'connection_event.dart';
part 'connection_states.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionStates> {
  StreamSubscription? _connectivity;
  ConnectionBloc() : super(ConnectionInitial()) {
    on<ConnectionEvent>((event, emit) {
      if (event is ConnectedEvent) {
        emit(ConnectedState(message: "internet connected successfully"));
      } else if (event is NotConnectedEvent) {
        emit(NotConnectedState(message: "you are in offline mode"));
      }
    });

    _connectivity = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        add(ConnectedEvent());
      } else {
        add(NotConnectedEvent());
      }
    });
  }
  @override
  Future<void> close() {
    _connectivity!.cancel();
    return super.close();
  }
}
