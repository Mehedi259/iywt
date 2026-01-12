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
          Assets.images.collegeCertificate.path,
          width: double.infinity,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      const SizedBox(height: 14),
      const Text(
          'A college certificate is an official document issued by an academic institution that verifies a students successful completion of a course, program, or academic requirement.',
      style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
    ),
    const SizedBox(height: 14),
    const Text(
    'It serves as an official proof of a students academic achievement, which may be required for higher studies, job applications, or other formal verification processes.',
    style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
    ),
    if (_showFullDescription) ...[
    const SizedBox(height: 14),
    const Text(
    'College certificates are essential for various purposes including university admissions, scholarship applications, employment verification, and professional licensing requirements.',
    style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
    ),
    const SizedBox(height: 14),
    const Text(
    'Students should ensure that their certificates are properly attested and verified by the issuing institution. It\'s advisable to keep both original and certified copies in a secure location.',
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
    '1. Contact Your Institution',
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 8),
    Text(
    'Visit or contact the administrative office or registrar of your college to inquire about the certificate issuance process.',
    style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 14),
    Text(
    '2. Submit Required Documents',
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 8),
    Text(
    'Provide necessary documents such as student ID, completed coursework records, clearance from library and accounts, and any applicable fees.',
    style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 14),
    Text(
    '3. Fill Application Form',
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 8),
    Text(
    'Complete the certificate request form with accurate personal and academic information as per college records.',
    style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 14),
    Text(
    '4. Wait for Processing',
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 8),
    Text(
    'The institution will verify your records and process the certificate. Processing time varies by institution, typically 7-30 days.',
    style: TextStyle(fontSize: 14, height: 1.43, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 14),
    Text(
    '5. Collect Your Certificate',
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D1B20)),
    ),
    SizedBox(height: 8),
    Text(
    'Once ready, collect your certificate from the designated office with proper identification. Some institutions also offer courier delivery.',
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
    'Keep a wallet-size copy of the college certificate for quick reference when needed.\nIt is also recommended to ensure that the document is kept safely and updated or re-issued if required.',
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
                            'Sample College Certificate',
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
                            Assets.images.collegeCertificate.path,
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