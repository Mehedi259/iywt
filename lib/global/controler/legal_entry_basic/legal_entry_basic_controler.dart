// lib/global/controler/legal_entry_basic/legal_entry_basic_controler.dart

import 'package:get/get.dart';
import 'dart:developer' as developer;
import '../../model/legal_entry_basic/legal_entry_basic_model.dart';
import '../../service/legal_entry_basic/legal_entry_basic_service.dart';

class LegalEntryBasicController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final Rx<LegalEntryBasicModel?> legalEntryData = Rx<LegalEntryBasicModel?>(null);

  // Expandable card states
  final isCountrySummaryExpanded = true.obs;
  final isImportantDatesExpanded = false.obs;
  final isInstructionsExpanded = false.obs;
  final isConsulateExpanded = false.obs;
  final isImportantNotesExpanded = false.obs;
  final isPostArrivalExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLegalEntryBasics();
  }

  /// Fetch Legal Entry Basics
  Future<void> fetchLegalEntryBasics() async {
    try {
      isLoading.value = true;

      developer.log('🔄 Fetching legal entry basics', name: 'LegalEntryBasicController');

      final result = await LegalEntryBasicService.getLegalEntryBasics();

      if (result['success'] == true) {
        legalEntryData.value = result['data'] as LegalEntryBasicModel;
        developer.log('✅ Legal entry basics loaded', name: 'LegalEntryBasicController');
      } else {
        developer.log('❌ Failed: ${result['error']}', name: 'LegalEntryBasicController');
      }
    } catch (e) {
      developer.log('❌ Error: $e', name: 'LegalEntryBasicController');
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle expandable cards
  void toggleCountrySummary() => isCountrySummaryExpanded.toggle();
  void toggleImportantDates() => isImportantDatesExpanded.toggle();
  void toggleInstructions() => isInstructionsExpanded.toggle();
  void toggleConsulate() => isConsulateExpanded.toggle();
  void toggleImportantNotes() => isImportantNotesExpanded.toggle();
  void togglePostArrival() => isPostArrivalExpanded.toggle();

  /// Refresh data
  Future<void> refreshData() async {
    await fetchLegalEntryBasics();
  }
}
