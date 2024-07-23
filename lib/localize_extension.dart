import './localize_state.dart';

extension Localization on String {
  String get localize {
    return localizeState.content[localizeState.currentLanguage]![this] ?? this;
  }
}
