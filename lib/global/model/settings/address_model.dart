// lib/global/model/settings/address_model.dart

class AddressModel {
  final String? address;
  final String? city;
  final String? stateProvince;
  final String? zipPostalCode;
  final String? county;
  final String? addressType;
  final String? addressId;

  AddressModel({
    this.address,
    this.city,
    this.stateProvince,
    this.zipPostalCode,
    this.county,
    this.addressType,
    this.addressId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      city: json['city'],
      stateProvince: json['stateProvince'],
      zipPostalCode: json['zipPostalCode'],
      county: json['county'],
      addressType: json['addressType'],
      addressId: json['addressId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'stateProvince': stateProvince,
      'zipPostalCode': zipPostalCode,
      'county': county,
      'addressType': addressType,
      'addressId': addressId,
    };
  }
}