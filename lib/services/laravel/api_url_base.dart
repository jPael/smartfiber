// Uri get apiURIBase => Uri(scheme: "http", host: "192.168.254.103", port: 8000);
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Uri get apiURIBase {
  if (kReleaseMode) {
    return Uri(
      scheme: "https",
      host: dotenv.env['REMOTE_BACKEND_API'],
    );
  } else {
    return Uri(
        scheme: "http",
        host: dotenv.env['LOCAL_BACKEND_API'],
        port: int.parse(dotenv.env['LOCAL_BACKEND_PORT'] ?? "8000"));
  }
}

class LaravelPaths {
  static const String register = "/api/register";
  static const String login = "/api/login";

  static const String predict = "/api/yolo9";
  static const String allBarangay = "/api/barangays";
  // static const String user = "/api/v1/user";
  // static const String patientInformation = "/api/v1/user/patient-information";
  // static const String barangay = "/api/v1/barangays";
  // static const String prenatal = "/api/v1/prenatal";
  // static const String allPrenatal = "/api/v1/prenatals";
  // static const String midwife = "/api/v1/midwife";
  // static const String reminder = "/api/v1/reminder";
  // static const String allReminders = "/api/v1/reminders";

  static String recentsById(int i) => "/api/recents/$i";

  static String imageUrl(String url) => apiURIBase.replace(path: "storage/$url").toString();
}
