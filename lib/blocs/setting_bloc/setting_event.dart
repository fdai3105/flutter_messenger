part of '../blocs.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class SettingChangeEvent extends SettingEvent {
  @override
  List<Object> get props => [];
}

class RestartAppEvent extends SettingEvent {
  @override
  List<Object> get props => [];
}
