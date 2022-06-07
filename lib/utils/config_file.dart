import 'dart:convert';
import 'dart:io';

/// ConfigFile is a class that helps you to create JSON config files easily.
class ConfigFile {
  ConfigFile(this.file, this.defaultValue, {this.route = const []}) {
    data = defaultValue;
  }
  /// The file that stores the config data.
  final File file;
  /// The default config data.
  final Map<String, dynamic> defaultValue;
  /// The JSON route to the current path.
  final List<String> route;

  /// The config data.
  late Map<String, dynamic> data;

  /// Save the config data to the file.
  Future<ConfigFile> save({bool compact = false}) async {
    if (!file.existsSync()) file.createSync(recursive: true);
    if (compact) {
      await file.writeAsString(jsonEncode(data));
    } else {
      await file
          .writeAsString(const JsonEncoder.withIndent("  ").convert(data));
    }
    return this;
  }

  /// Load the config data from the file.
  Future<ConfigFile> load() async {
    if (!file.existsSync()) await save();
    try {
      data = jsonDecode(file.readAsStringSync());
    } catch (e) {
      print(e);
      await save(); //ファイルを変更前に戻す
    }
    return this;
  }

  /// Set value to JSON object.
  ConfigFile set({String? key, dynamic value}) {
    if (key == null) {
      if (route.isEmpty) return this;
      getPreObjectFromPath()[route.last] = value;
      return this;
    }
    getObjectFromPath()[key] = value;
    return this;
  }

  /// Delete key from JSON object.
  ConfigFile delete({String? key}) {
    if (key == null) {
      if (route.isEmpty) return this;
      getPreObjectFromPath().remove(route.last);
      return this;
    }
    getObjectFromPath().remove(key);
    return this;
  }

  /// Get value from JSON object. If key is not provided, return the value at current path.
  dynamic getValue(String? key) {
    if (key == null) {
      if (route.isEmpty) return data;
      return getPreObjectFromPath()[route.last];
    } else {
      return getObjectFromPath()[key];
    }
  }

  /// Get ConfigFile instance of the path.
  ConfigFile get(List<String> keys) {
    List<String> newRoute = [...route];
    newRoute.addAll(keys);
    return ConfigFile(file, defaultValue, route: newRoute);
  }

  /// Check if the key exists in the JSON object.
  bool has(String key) {
    return getObjectFromPath().containsKey(key);
  }

  /// Check if the current path exists.
  bool exists() {
    if (route.isEmpty) return true;
    return getPreObjectFromPath().containsKey(route.last);
  }

  /// Reset the config data to the default value.
  ConfigFile resetData() {
    data = defaultValue;
    return this;
  }

  /// Clear the stored route. This means that you can get the root ConfigFile instance.
  ConfigFile resetPath() {
    route.clear();
    return this;
  }

  /// Get the JSON object at the current path.
  Map<String, dynamic> getObjectFromPath() {
    Map<String, dynamic> mutableData = data;
    for (int i = 0; i < route.length; i++) {
      final k = route[i];
      if (!mutableData.containsKey(k)) mutableData[k] = {};
      mutableData = mutableData[k];
    }
    return mutableData;
  }

  /// Get the parent JSON object of the current path.
  Map<String, dynamic> getPreObjectFromPath() {
    Map<String, dynamic> mutableData = data;
    for (int i = 0; i < route.length - 1; i++) {
      final k = route[i];
      if (!mutableData.containsKey(k)) mutableData[k] = {};
      mutableData = mutableData[k];
    }
    return mutableData;
  }
}
