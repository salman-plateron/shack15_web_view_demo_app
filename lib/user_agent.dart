import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getUserAgent() async {
  final deviceInfo = DeviceInfoPlugin();
  String userAgent = "FlutterApp";

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    userAgent =
        "FlutterApp/Android ${androidInfo.version.release} (${androidInfo.model})";
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    userAgent =
        "FlutterApp/iOS ${iosInfo.systemVersion} (${iosInfo.utsname.machine})";
  }

  return userAgent;
}
