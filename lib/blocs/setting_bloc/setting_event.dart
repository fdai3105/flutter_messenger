part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class SettingChangeEvent extends SettingEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class RestartAppEvent extends SettingEvent {
  @override
  List<Object> get props => [];
}
