part of '../blocs.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial());

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if (event is SettingChangeEvent) {
    } else if (event is RestartAppEvent) {
      yield RestartAppState();
    }
  }
}

