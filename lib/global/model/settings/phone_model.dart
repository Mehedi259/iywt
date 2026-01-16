// lib/global/model/settings/phone_model.dart

class PhoneModel {
  final String? phone;
  final String? phoneType;
  final String? phoneId;

  PhoneModel({
    this.phone,
    this.phoneType,
    this.phoneId,
  });

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      phone: json['phone'],
      phoneType: json['phoneType'],
      phoneId: json['phoneId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'phoneType': phoneType,
      'phoneId': phoneId,
    };
  }
}