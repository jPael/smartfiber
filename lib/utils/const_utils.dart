import 'package:smartfiber/models/new_user.dart';
// import 'package:smartfiber/models/reminder.dart';
import 'package:smartfiber/models/trimester.dart';

// ReminderTypeEnum? getReminderTypeEnumFromReminderInt(int i) {
//   switch (i) {
//     case 1:
//       return ReminderTypeEnum.prenatalCheckup;
//     case 2:
//       return ReminderTypeEnum.nutritionSeminar;
//     case 3:
//       return ReminderTypeEnum.vaccinationDrive;
//     default:
//       return null;
//   }
// }

String getUserStringFromUserTypeEnum(UserType type) {
  switch (type) {
    case UserType.mother:
      return "MOTHER";
    case UserType.midwife:
      return "MIDWIFE";
  }
}

UserType getUserEnumFromUserTypeString(String type) {
  switch (type) {
    case "MOTHER":
      return UserType.mother;
    case "MIDWIFE":
      return UserType.midwife;
    default:
      throw ArgumentError("Invalid user type: $type");
  }
}

int getIntegerFromUserTypeEnum(UserType type) {
  switch (type) {
    case UserType.mother:
      return 2;
    case UserType.midwife:
      return 1;
  }
}

String getTrimesterStringFromTrimesterEnum(TrimesterEnum t) {
  switch (t) {
    case TrimesterEnum.first:
      return "FIRST";
    case TrimesterEnum.second:
      return "SECOND";
    case TrimesterEnum.third:
      return "THIRD";
  }
}

TrimesterEnum getTrimesterEnumFromTrimesterString(String t) {
  switch (t) {
    case "1ST_TRIMESTER":
      return TrimesterEnum.first;
    case "2ND_TRIMESTER":
      return TrimesterEnum.second;
    case "3RD_TRIMESTER":
      return TrimesterEnum.third;
    default:
      throw ArgumentError("Invalid trimester: $t");
  }
}

int getIntegerTrimesterEnum(TrimesterEnum t) {
  switch (t) {
    case TrimesterEnum.first:
      return 1;
    case TrimesterEnum.second:
      return 2;
    case TrimesterEnum.third:
      return 3;
  }
}
