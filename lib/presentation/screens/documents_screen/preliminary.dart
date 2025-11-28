import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iywt/core/routes/routes.dart';
import '../../../core/routes/route_path.dart';
import '../../../core/custom_assets/assets.gen.dart';

class PreliminaryScreen extends StatelessWidget {
  const PreliminaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),

      // ------------------ APP BAR ------------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: Image(
            image: Assets.images.backIcon.provider(),
            height: 40,
            width: 40,
          ),
          onPressed: () => context.go(RoutePath.documents.addBasePath),
        ),

        title: const Text(
          "Preliminary",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image(image: Assets.images.cross.provider()),
                ),
                const SizedBox(width: 6),
                const Text(
                  "1/2",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),

      // ------------------ BODY ------------------
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDocumentItem(
              title: "Passport",
              description:
              "You will upload a high-quality scan of the bio-page of your passport.",
              onPressed: () => context.go(RoutePath.passport.addBasePath),
              isComplete: true,
              width: width,
            ),
            const SizedBox(height: 16),

            _buildDocumentItem(
              title: "Birth Certificate",
              description:
              "You will upload a copy of your birth certificate to verify parental consent.",
              onPressed: () => context.go(RoutePath.preliminary.addBasePath),
              isComplete: false,
              width: width,
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ DOCUMENT CARD ------------------
  Widget _buildDocumentItem({
    required String title,
    required String description,
    required bool isComplete,
    required VoidCallback onPressed,
    required double width,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPressed,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // ---------- TEXT ----------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1D1B20),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9E9E9E),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // ---------- STATUS ICON ----------
            SizedBox(
              width: 26,
              height: 26,
              child: Image(
                image: isComplete
                    ? Assets.images.correct.provider()
                    : Assets.images.cross.provider(),
              ),
            ),

            const SizedBox(width: 6),

            // ---------- ARROW ----------
            Icon(
              Icons.chevron_right,
              size: 26,
              color: Colors.grey.shade400,
            )
          ],
        ),
      ),
    );
  }
}
