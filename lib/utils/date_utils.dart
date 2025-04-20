import 'package:intl/intl.dart';

String formatDayLeft(Duration difference) {
  if (difference.inDays == 0) {
    return "Today";
  } else if (difference.inDays == 1) {
    return "1 day left";
  } else if (difference.inDays < 7) {
    return "${difference.inDays} days left";
  } else if (difference.inDays < 14) {
    return "1 week left";
  } else {
    return "${(difference.inDays / 7).floor()} weeks left";
  }
}

int calculateAge(DateTime birthday) {
  final now = DateTime.now();

  // Check if birthday is in the future
  if (birthday.isAfter(now)) {
    throw ArgumentError("Birthday cannot be in the future");
  }

  int age = now.year - birthday.year;

  // Adjust if birthday hasn't occurred yet this year
  if (now.month < birthday.month || (now.month == birthday.month && now.day < birthday.day)) {
    age--;
  }

  return age;
}

// Helper function to parse date from string (optional)
DateTime parseBirthday(String dateString) {
  try {
    return DateTime.parse(dateString);
  } catch (e) {
    // Alternative parsing with intl package if needed
    final format = DateFormat('yyyy-MM-dd');
    return format.parse(dateString);
  }
}
