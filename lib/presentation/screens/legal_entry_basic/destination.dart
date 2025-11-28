import 'package:flutter/material.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';
import '../../../core/custom_assets/assets.gen.dart';

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Legal Entry Basics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCountrySummaryCard(),
            const SizedBox(height: 16),

            // Expandable Cards with images only
            _buildExpandableCard(
              image: Assets.images.importantDates.provider(),
              title: 'Important Dates',
            ),
            const SizedBox(height: 12),
            _buildExpandableCard(
              image: Assets.images.instructionForDocumentSubmission.provider(),
              title: 'Instructions for Document\nSubmission',
            ),
            const SizedBox(height: 12),
            _buildExpandableCard(
              image: Assets.images.consulateOrOtherVisits.provider(),
              title: 'Consulate or Other Visits',
            ),
            const SizedBox(height: 12),
            _buildExpandableCard(
              image: Assets.images.importantNotes.provider(),
              title: 'Important Notes',
            ),
            const SizedBox(height: 12),
            _buildExpandableCard(
              image: Assets.images.postArrivalinstructions.provider(),
              title: 'Post Arrival Instructions',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 1),
    );
  }

  // Country Summary Card
  Widget _buildCountrySummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                // Country Flag
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: Assets.images.country.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Country Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_up, size: 24),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The destination country, Canada, offers a vibrant multicultural environment and a high quality of education. Students are encouraged to embrace its diverse culture and strict legal framework. Understanding local laws is key for a smooth stay.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Background Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Assets.images.countrySummeryImage.image(
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 16),
                const Text(
                  'Key Facts:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                _buildKeyFact('Official Languages: English, French'),
                _buildKeyFact('Currency: Canadian Dollar (CAD)'),
                _buildKeyFact('Emergency Number: 911'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Key Fact Row
  Widget _buildKeyFact(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, right: 8),
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Expandable Card (Image only)
  Widget _buildExpandableCard({
    required String title,
    required ImageProvider image,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 24, color: Colors.grey),
        ],
      ),
    );
  }
}
