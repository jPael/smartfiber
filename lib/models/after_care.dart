class AfterCare {
  final List<Immunization> immunzation;
  final List<IronSupplement> ironSupplement;

  AfterCare({
    required this.immunzation,
    required this.ironSupplement,
  });
}

class Immunization {
  final int term;
  final DateTime? date;

  Immunization({
    required this.term,
    this.date,
  });
}

class IronSupplement {
  final DateTime? date;
  final int tabs;

  IronSupplement({
    this.date,
    required this.tabs,
  });
}
