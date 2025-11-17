import 'package:flutter/material.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';

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
            _buildExpandableCard(
              icon: Icons.calendar_today,
              title: 'Important Dates',
              color: const Color(0xFF5B7FBF),
            ),
            const SizedBox(height: 12),
            _buildExpandableCard(
              icon: Icons.upload_file,
              title: 'Instructions for Document\nSubmission',
              color: const Color(0xFF5B7FBF),
            ),
            const SizedBox(height: 12),
            _buildExpandableCard(
              icon: Icons.location_city,
              title: 'Consulate or Other Visits',
              color: const Color(0xFF5B7FBF),
            ),
            const SizedBox(height: 12),
            _buildExpandableCard(
              icon: Icons.lightbulb_outline,
              title: 'Important Notes',
              color: const Color(0xFF5B7FBF),
            ),
            const SizedBox(height: 12),
            _buildExpandableCard(
              icon: Icons.flight_land,
              title: 'Post Arrival Instructions',
              color: const Color(0xFF5B7FBF),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 1),
    );
  }

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
                Container(
                  width: 32,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://flagcdn.com/w40/ro.png',
                      ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=600',
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

  Widget _buildExpandableCard({
    required IconData icon,
    required String title,
    required Color color,
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
          Icon(icon, color: color, size: 24),
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
