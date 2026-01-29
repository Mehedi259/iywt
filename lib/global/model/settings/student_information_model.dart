// lib/global/model/settings/student_information_model.dart

class StudentInformationModel {
  final String? profilePhotoUrl;
  final String? preferredName;
  final String? dateOfBirth;
  final String? gender;
  final String? parentLegalGuardianOneName;
  final String? parentLegalGuardianTwoName;
  final String? pronouns;

  StudentInformationModel({
    this.profilePhotoUrl,
    this.preferredName,
    this.dateOfBirth,
    this.gender,
    this.parentLegalGuardianOneName,
    this.parentLegalGuardianTwoName,
    this.pronouns,
  });

  factory StudentInformationModel.fromJson(Map<String, dynamic> json) {
    return StudentInformationModel(
      profilePhotoUrl: json['profilePhotoUrl'],
      preferredName: json['preferredName'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      parentLegalGuardianOneName: json['parentLegalGuardianOneName'],
      parentLegalGuardianTwoName: json['parentLegalGuardianTwoName'],
      pronouns: json['pronouns'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preferredName': preferredName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'parentLegalGuardianOneName': parentLegalGuardianOneName,
      'parentLegalGuardianTwoName': parentLegalGuardianTwoName,
      'pronouns': pronouns,
    };
  }
}