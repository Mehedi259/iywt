// lib/global/model/settings/technical_support_model.dart

class TechnicalSupportModel {
  final String subject;
  final String issue;

  TechnicalSupportModel({
    required this.subject,
    required this.issue,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'issue': issue,
    };
  }
}