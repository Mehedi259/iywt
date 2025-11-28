import 'package:flutter/material.dart';
import '../../../../core/custom_assets/assets.gen.dart';

class DetailsTab extends StatelessWidget {
  final double horizontalPadding;

  const DetailsTab({
    super.key,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFDFDFD),
              border: Border.all(
                width: 0.5,
                color: const Color(0xFFC7C7C7),
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F7),
                    border: Border(bottom: BorderSide(color: Color(0xFFB0B0B0), width: 0.5)),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(Assets.images.descriptionIcon.path, width: 20, height: 20),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Description',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_up),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          Assets.images.passport.path,
                          width: 157,
                          height: 118,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'A passport is a formal document issued by a country to one of its citizens. It is usually necessary for exit from and re-entry into the home country.',
                        style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'It allows the citizen to travel in a foreign country following legal entry requirements and requests protection for the citizen while in another country.',
                        style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                      ),
                      const SizedBox(height: 14),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                        child: const Text(
                          'See more',
                          style: TextStyle(color: Color(0xFF375BA4), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _buildSimpleCard(
            iconAsset: Assets.images.instructionIcon,
            title: 'Instruction',
            trailing: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1D1B20)),
          ),
          const SizedBox(height: 10),
          _buildSimpleCard(
            iconAsset: Assets.images.sampleDocument,
            title: 'Sample Document',
            trailing: const Text('View', style: TextStyle(color: Color(0xFF375BA4), fontSize: 12, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 14),
          _buildExpandableCard(
            iconAsset: Assets.images.keytipsIcon,
            title: 'Key tips',
            isExpanded: true,
            child: const Text(
              'Make a wallet-size copy of the passport to carry while traveling.\nRotary recommends parents also have a Passport valid through January 2026.',
              style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildExpandableCard({
    required AssetGenImage iconAsset,
    required String title,
    required bool isExpanded,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        border: Border.all(color: const Color(0xFFB0B0B0), width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              border: const Border(bottom: BorderSide(color: Color(0xFFB0B0B0), width: 0.5)),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Image.asset(iconAsset.path, width: 20, height: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
              ],
            ),
          ),
          if (isExpanded)
            Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }

  Widget _buildSimpleCard({
    required AssetGenImage iconAsset,
    required String title,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        border: Border.all(color: const Color(0xFFB0B0B0), width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(iconAsset.path, width: 20, height: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
          trailing,
        ],
      ),
    );
  }
}