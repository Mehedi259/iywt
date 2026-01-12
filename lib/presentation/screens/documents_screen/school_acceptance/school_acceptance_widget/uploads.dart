import 'package:flutter/material.dart';

class UploadsTab extends StatelessWidget {
  final double horizontalPadding;

  const UploadsTab({
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Scan Uploads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFDFD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('28 Apr 2025', style: TextStyle(fontSize: 12, color: Color(0xFFC7C7C7))),
                            SizedBox(height: 4),
                            Text('Uploaded by', style: TextStyle(fontSize: 8, color: Color(0xFFC7C7C7))),
                            Text('aaron@jivt.com', style: TextStyle(fontSize: 16, color: Color(0xFF1D1B20))),
                            SizedBox(height: 8),
                            Text('Description', style: TextStyle(fontSize: 8, color: Color(0xFFC7C7C7))),
                            Text('Anello-Dennee School Acceptance Letters', style: TextStyle(fontSize: 12, color: Color(0xFF1D1B20))),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View scan', style: TextStyle(color: Color(0xFF375BA4))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}