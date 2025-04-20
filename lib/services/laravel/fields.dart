class RegistrationFields {
  static const String username = "username";
  static const String name = "name";
  static const String email = "email";
  static const String password = "password";
  static const String passwordConfirmation = "password_confirmation";
  static const String barangay = "barangay";
  static const String userType = "role_id";
  static const String phone = "phone_number";
}

class RegistrationResponseJsonProperties {
  static String get message => "message";
  static String get errors => "errors";
}

class LaravelUserFields {
  static String get id => "id";
  static String get name => "name";
  static String get phoneNumber => "phone";
  static String get email => "email";
  static String get address => "barangay_id";
  static String get dateOfBirth => "date_of_birth";
  static String get password => "password";
  static String get token => "token";
  static String get roleId => "role_id";
  static String get roleName => "role_name";
  static String get userId => "user_id";
  static String get barangayId => "barangay_id";
  static String get barangay => "barangay";
  static String get createdAt => "created_at";
  static String get updatedAt => "updated_at";
}

class PrenatalFields {
  static const String patientInformationAccompaniedBy = 'patient_information_accompany_by';
  static const String patientInformationUserId = 'patient_information_user_id';
  static const String immunizationTerm = 'tt_imunizations';
  static const String ironSupplements = 'iron_supplements';
  static const String ironSupplementNoTabs = 'iron_supplement_no_tabs';
  static const String isBreastFeeding = 'is_breast_feeding';
  static const String isFamilyPlanning = 'is_family_planning';
  static const String isChildProperNutrition = 'is_child_proper_nutrition';
  static const String isSelfProperNutrition = 'is_self_proper_nutrition';
  static const String donorFullname = 'full_name';
  static const String donorContactNumber = 'contact_number';
  static const String donorBloodType = 'blood_type';
  static const String clinicVisitTrimester = 'clinic_visit_trimester';
  static const String clinicVisitConsultWht = 'clinic_visit_consul_wht';
  static const String clinicVisitWhtIntroducedBirthPlan = 'clinic_visit_wht_introduced_birth_plan';
  static const String clinicVisitFundicHeight = 'clinic_visit_fundic_heigh';
  static const String services = 'service';
  static const String advices = 'advice';
  static const String serviceContent = 'service_content';
  static const String adviceContent = 'advice_content';
  static const String trimester = 'trimester';
  static const String consultWht = 'consul_wht';
  static const String whtIntroducedBirthPlan = 'wht_introduced_birth_plan';
  static const String fundicHeight = 'fundic_heigh';
  static const String bloodPressure = 'blood_pressure';
  static const String patientInformationId = 'patient_information_id';
  static const String birthPlace = 'birth_place';
  static const String barangay = 'barangay';
  static const String birthday = 'birthday';
  static const String counselings = 'counselings';
  static const String bloodDonors = 'blood_donors';
  static const String clinicVisits = 'clinic_visits';
  static const String createdAt = 'created_at';
  static const String id = 'id';
  static const String updatedAt = 'updated_at';

  // static const String
}

class PatientInformationFields {
  static const String id = 'id';
  static const String philhealth = "philhealt";
  static const String nhts = 'nhts';
  static const String lmp = 'lmp';
  static const String obStatus = 'ob_status';
  static const String edc = 'edc';
  static const String assignedBy = 'assigned_by';
  static const String accompanyBy = 'accompany_by';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String accompanyByData = 'accompany_by_person';
  static const String assignedByData = 'assigned_by_person';
}
