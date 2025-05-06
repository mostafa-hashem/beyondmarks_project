class StudentInputModel {
  final String gender;
  final String race;
  final String parentalEducation;
  final String lunch;
  final String testPreparation;

  StudentInputModel({
    required this.gender,
    required this.race,
    required this.parentalEducation,
    required this.lunch,
    required this.testPreparation,

  });

  Map<String, dynamic> toJson() {
    return {
      "race/ethnicity": race,
      "gender": gender,
      "lunch": lunch,
      "test preparation course": testPreparation,
      "parental level of education": parentalEducation,
    };
  }
}
