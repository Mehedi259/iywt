// lib/global/service/settings/address_service.dart

import 'package:flutter/foundation.dart';
import '../../constant/api_constant.dart';
import '../../model/settings/address_model.dart';
import '../api_services.dart';

class AddressService {
  // Get all addresses
  static Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.studentAddresses);
      if (response != null && response is List) {
        return response.map((json) => AddressModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error fetching addresses: $e');
      return [];
    }
  }

  // Update address by ID using PATCH
  static Future<bool> updateAddress(String addressId, AddressModel address) async {
    try {
      await ApiService.patchRequest(
        ApiConstants.studentAddressById(addressId),
        body: address.toJson(),
      );
      return true;
    } catch (e) {
      debugPrint('Error updating address: $e');
      return false;
    }
  }
}
