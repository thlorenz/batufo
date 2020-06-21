import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserSettings extends Equatable {
  final bool soundEffectsEnabled;
  const UserSettings({@required this.soundEffectsEnabled});

  List<Object> get props => [soundEffectsEnabled];

  UserSettings copyWith({bool soundEffectsEnabled}) {
    return UserSettings(
      soundEffectsEnabled: soundEffectsEnabled ?? this.soundEffectsEnabled,
    );
  }

  factory UserSettings.initial() {
    return UserSettings(soundEffectsEnabled: true);
  }
}
