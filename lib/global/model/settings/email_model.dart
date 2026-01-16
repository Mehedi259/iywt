// lib/global/model/settings/email_model.dart

class EmailModel {
  final String? email;
  final String? emailType;
  final String? emailId;

  EmailModel({
    this.email,
    this.emailType,
    this.emailId,
  });

  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return EmailModel(
      email: json['email'],
      emailType: json['emailType'],
      emailId: json['emailId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'emailType': emailType,
      'emailId': emailId,
    };
  }
}