class Trimester {
  final TrimesterEnum trimester;
  final DateTime dateOfVisit;
  final bool consultWht;
  final bool introducedBirthPlan;
  final String fundicHeight;
  final bool isFundicNormal;
  final String bloodPressure;
  final bool isBloodPressureNormal;
  final List<String> advices;
  final List<String> services;
  final String whtPersonnel;

  Trimester({
    required this.whtPersonnel,
    required this.trimester,
    required this.dateOfVisit,
    required this.consultWht,
    required this.introducedBirthPlan,
    required this.fundicHeight,
    required this.isFundicNormal,
    required this.bloodPressure,
    required this.isBloodPressureNormal,
    required this.advices,
    required this.services,
  });
}

enum TrimesterEnum { first, second, third }

extension TrimesterEnumExtenion on TrimesterEnum {
  String get label {
    switch (this) {
      case TrimesterEnum.first:
        return "First Trimester";
      case TrimesterEnum.second:
        return "Second Trimester";
      case TrimesterEnum.third:
        return "Third Trimester";
    }
  }

  int get value {
    switch (this) {
      case TrimesterEnum.first:
        return 1;
      case TrimesterEnum.second:
        return 2;
      case TrimesterEnum.third:
        return 3;
    }
  }
}
