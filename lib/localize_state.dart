import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _LocalizeState extends ChangeNotifier {
  late Map<String, Map<String, String>> content;
  late String currentLanguage;
  final prefKey = 'LOCALIZE_LANGUAGE';

  void init({
    required Map<String, Map<String, String>> content,
  }) {
    this.content = content;
    currentLanguage = content.keys.first;

    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      if (prefs.containsKey(prefKey)) currentLanguage = prefs.getString(prefKey)!;
    });
  }

  void setLanguage(String language) {
    if (content.containsKey(language)) {
      currentLanguage = language;

      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        prefs.setString(prefKey, language);
      });

      notifyListeners();
    }
  }

  List<String> get languages {
    return content.keys.toList();
  }
}

var localizeState = _LocalizeState();
