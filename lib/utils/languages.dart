import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

/// Language is a class that helps you to create multi-language app.
class Language {
  /// List of supported languages. (e.g. ["en_US", "ja_JP"])
  static final List<String> languages = [];

  /// User's language data.
  static late Map<String, dynamic> currentLanguage;

  /// Initialize the languages.
  ///
  /// Make sure to create an asset file named "(language)\_(country).json" like "en\_US.json"
  /// in your "assets/lang/" folder.
  static Future<void> init(List<String> langs) async {
    languages.addAll(langs);
    final String locale = Platform.localeName;

    // can throw error (e.g. Unable to load asset: assets/lang/ja_JP.json)
    final isSupported = await loadLanguage(locale);
    if (!isSupported && locale != "en_US") await loadLanguage("en_US");
  }

  /// Get the text from the current language.
  static String getText(String key) {
    return currentLanguage[key] ?? "";
  }

  /// Load the language data from the assets.
  static Future<bool> loadLanguage(String language) async {
    if (!languages.contains(language)) return false;
    final String content =
        await rootBundle.loadString("assets/lang/$language.json");
    final Map<String, dynamic> json = jsonDecode(content);
    currentLanguage = json;
    return true;
    // await SettingsData.settings.set(key: "language", value: language).save();
  }
}
