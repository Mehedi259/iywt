import 'package:flutter/material.dart';

import '../../../../../core/custom_assets/assets.gen.dart';

class DetailsTab extends StatefulWidget {
  final double horizontalPadding;

  const DetailsTab({
    super.key,
    required this.horizontalPadding,
  });

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> {
  bool _showFullDescription = false;
  bool _isInstructionExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
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
                          width: double.infinity,
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
                      if (_showFullDescription) ...[
                        const SizedBox(height: 14),
                        const Text(
                          'Passports contain important personal information including the holder\'s photograph, full name, date of birth, nationality, and a unique passport number. They also include security features to prevent forgery.',
                          style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Most passports are valid for 5-10 years and must be renewed before expiration. Many countries require your passport to be valid for at least 6 months beyond your planned travel dates.',
                          style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                        ),
                      ],
                      const SizedBox(height: 14),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showFullDescription = !_showFullDescription;
                          });
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                        child: Text(
                          _showFullDescription ? 'See less' : 'See more',
                          style: const TextStyle(color: Color(0xFF375BA4), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _buildExpandableCard(
            iconAsset: Assets.images.instructionIcon,
            title: 'Instruction',
            isExpanded: _isInstructionExpanded,
            onTap: () {
              setState(() {
                _isInstructionExpanded = !_isInstructionExpanded;
              });
            },
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Gather Required Documents',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 8),
                Text(
                  'Collect necessary documents including national ID card or birth certificate, recent passport-sized photographs with white background, and proof of address.',
                  style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 14),
                Text(
                  '2. Complete Application Form',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 8),
                Text(
                  'Fill out the passport application form online at the Department of Immigration and Passports website or obtain a physical form from the passport office. Ensure all information is accurate.',
                  style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 14),
                Text(
                  '3. Schedule Appointment',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 8),
                Text(
                  'Book an appointment at your nearest passport office or regional office through the online system. Choose a convenient date and time slot.',
                  style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 14),
                Text(
                  '4. Submit Application & Pay Fee',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 8),
                Text(
                  'Visit the passport office on your scheduled date with all original documents and photocopies. Submit your application, provide biometric data (fingerprints and photograph), and pay the required fee.',
                  style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 14),
                Text(
                  '5. Collect Your Passport',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
                ),
                SizedBox(height: 8),
                Text(
                  'Processing typically takes 7-21 working days. You can track your application status online. Collect your passport from the designated office with your acknowledgment receipt and valid ID.',
                  style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildSimpleCard(
            iconAsset: Assets.images.sampleDocument,
            title: 'Sample Document',
            trailing: const Text('View', style: TextStyle(color: Color(0xFF375BA4), fontSize: 12, fontWeight: FontWeight.w500)),
            onTap: () {
              _showImageDialog(context);
            },
          ),
          const SizedBox(height: 14),
          _buildExpandableCard(
            iconAsset: Assets.images.keytipsIcon,
            title: 'Key tips',
            isExpanded: true,
            onTap: null,
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

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sample Passport',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            Assets.images.passport.path,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExpandableCard({
    required AssetGenImage iconAsset,
    required String title,
    required bool isExpanded,
    required Widget child,
    VoidCallback? onTap,
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
          InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Container(
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
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
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
      ),
    );
  }
}