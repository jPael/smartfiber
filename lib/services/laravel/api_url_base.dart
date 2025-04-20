Uri get apiURIBase => Uri(scheme: "http", host: "192.168.92.34", port: 8000);

class LaravelPaths {
  static const String register = "/api/register";
  static const String login = "/api/login";

  static const String predict = "/api/yolo9";
  // static const String user = "/api/v1/user";
  // static const String patientInformation = "/api/v1/user/patient-information";
  // static const String barangay = "/api/v1/barangays";
  // static const String prenatal = "/api/v1/prenatal";
  // static const String allPrenatal = "/api/v1/prenatals";
  // static const String midwife = "/api/v1/midwife";
  // static const String reminder = "/api/v1/reminder";
  // static const String allReminders = "/api/v1/reminders";

  static String recentsById(int i) => "/api/recents/$i";
}
