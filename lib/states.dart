import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:event/event.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MedicaminaThemeState {
  static late bool _darkMode;
  var changedState = Event();

  MedicaminaThemeState() {
    setDarkModeFromDeviceBrightness();
  }

  ThemeMode getThemeMode() {
    if (_darkMode) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  void setDarkModeFromDeviceBrightness() {
    // TODO: Check this?
    var platformBrightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    if (platformBrightness == Brightness.dark) {
      _darkMode = true;
      return;
    }
    _darkMode = false;
  }

  void setDarkMode(bool isDark) {
    _darkMode = isDark;
  }

  bool getDarkMode() {
    return _darkMode;
  }
}

class MedicaminaUserState {
  static String? jwtToken;

  MedicaminaUserState();

  void login(String token) {
    jwtToken = token;
  }

  void logout() {
    jwtToken = null;
  }

  String? getToken() {
    return jwtToken;
  }
}






// Future<File?> compressFile(File file, {int quality = 30}) async {
//   final dir = await path_provider.getTemporaryDirectory();
//   final targetPath = dir.absolute.path + '/${Random().nextInt(1000)}-temp.jpg';

//   var _compressedFile = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path,
//     targetPath,
//     quality: quality,
//   );

//   return File(_compressedFile!.path);
// }
