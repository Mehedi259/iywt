import 'package:flutter/material.dart';

import '../../../../../core/custom_assets/assets.gen.dart';

class StatusTab extends StatelessWidget {
  final double horizontalPadding;

  const StatusTab({
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
                const Text(
                  'Current',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                    color: Color(0xFF1D1B20),
                  ),
                ),
                const SizedBox(height: 14),
                _buildStatusCard(
                  context,
                  date: '28 Apr 2025',
                  email: 'aaron@jivt.com',
                  status: 'incomplete',
                  showDetails: false,
                ),
                const SizedBox(height: 11),
                _buildStatusCard(
                  context,
                  date: '28 Apr 2025',
                  email: 'aaron@jivt.com',
                  status: 'warning',
                  showDetails: true,
                ),
                const SizedBox(height: 11),
                _buildStatusCard(
                  context,
                  date: '28 Apr 2025',
                  email: 'aaron@jivt.com',
                  status: 'complete',
                  showDetails: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
      BuildContext context, {
        required String date,
        required String email,
        required String status,
        required bool showDetails,
      }) {
    final Map<String, dynamic> statusInfo = {
      'complete': {'icon': Assets.images.correct},
      'warning': {'icon': Assets.images.alert},
      'incomplete': {'icon': Assets.images.incomplete },
    }[status] ?? {'icon': Assets.images.cross };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFDFDFD)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFC7C7C7),
                  ),
                ),
                const SizedBox(height: 8.28),
                const Text(
                  'Created by',
                  style: TextStyle(
                    fontSize: 8,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFC7C7C7),
                  ),
                ),
                const SizedBox(height: 0),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1D1B20),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          showDetails
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                statusInfo['icon'].path,
                width: 18.91,
                height: 18.91,
                color: statusInfo['color'],
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => _showDetailsDialog(context),
                child: const Text(
                  'View details',
                  style: TextStyle(
                    color: Color(0xFF375BA4),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          )
              : Image.asset(
            statusInfo['icon'].path,
            width: 18.91,
            height: 18.91,
            color: statusInfo['color'],
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 314,
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFDFD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.images.incomplete.path,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Incomplete',
                      style: TextStyle(
                        color: Color(0xFF1D1B20),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 38.75),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFC7C7C7),
                ),
                const SizedBox(height: 16.25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.images.issue.path,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Issue',
                            style: TextStyle(
                              color: Color(0xFF1D1B20),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'School Acceptance Letters is not signed',
                            style: TextStyle(
                              color: Color(0xFF1D1B20),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.images.correct.path,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resolution',
                            style: TextStyle(
                              color: Color(0xFF1D1B20),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Sign your School Acceptance Letters and upload a new copy',
                            style: TextStyle(
                              color: Color(0xFF1D1B20),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}