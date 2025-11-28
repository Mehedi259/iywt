import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iywt/core/routes/routes.dart';
import '../../../core/routes/route_path.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';
import '../../../core/custom_assets/assets.gen.dart';

enum DocumentStatus { complete, incomplete, warning }

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: const Text(
          'Documents',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
            color: Color(0xFF1D1B20),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
        child: Column(
          children: [
            _buildDocumentCard(
              context: context,
              title: 'Preliminary',
              onTap: () => context.go(RoutePath.preliminary.addBasePath),
              iconImage: Assets.images.preliminary.provider(),
              iconSize: 38.16,
              iconLeft: 7,
              iconTop: 7.38,
              progress: 5,
              total: 5,
              status: DocumentStatus.complete,
            ),
            const SizedBox(height: 12.91),
            _buildDocumentCard(
              context: context,
              title: 'Student',
              onTap: () => context.go(RoutePath.student.addBasePath),
              iconImage: Assets.images.student.provider(),
              iconSize: 36,
              iconLeft: 6,
              iconTop: 6.55,
              progress: 3,
              total: 5,
              status: DocumentStatus.incomplete,
            ),
            const SizedBox(height: 12.91),
            _buildDocumentCard(
              context: context,
              title: 'Country',
              onTap: () => context.go(RoutePath.country.addBasePath),
              iconImage: Assets.images.country.provider(),
              iconSize: 36,
              iconLeft: 7,
              iconTop: 7,
              progress: 2,
              total: 5,
              status: DocumentStatus.warning,
              isCountryFlag: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }

  Widget _buildDocumentCard({
    required BuildContext context,
    required String title,
    required ImageProvider iconImage,
    required double iconSize,
    required double iconLeft,
    required double iconTop,
    required int progress,
    required int total,
    required DocumentStatus status,
    required VoidCallback onTap,
    bool isCountryFlag = false,
  }) {
    // Calculate positions based on Figma design
    double cardTop = 0;
    double titleTop = 0;
    double iconContainerTop = 0;
    double progressTop = 0;
    double statusIconTop = 0;
    double chevronTop = 0;

    if (title == 'Preliminary') {
      cardTop = 132;
      titleTop = 201;
      iconContainerTop = 148.62;
      progressTop = 181;
      statusIconTop = 182;
      chevronTop = 180;
    } else if (title == 'Student') {
      cardTop = 264;
      titleTop = 334.55;
      iconContainerTop = 283.55;
      progressTop = 313;
      statusIconTop = 316;
      chevronTop = 312;
    } else if (title == 'Country') {
      cardTop = 396;
      titleTop = 463;
      iconContainerTop = 414;
      progressTop = 445;
      statusIconTop = 448;
      chevronTop = 444;
    }

    // Status icon
    ImageProvider? statusImage;
    double statusIconSize = 20;
    if (status == DocumentStatus.complete) {
      statusImage = Assets.images.correct.provider();
    } else if (status == DocumentStatus.warning) {
      statusImage = Assets.images.alert.provider();
      statusIconSize = 16;
    }else if (status == DocumentStatus.incomplete) {
      statusImage = Assets.images.cross.provider();
      statusIconSize = 16;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 353,
        height: 119.09,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // Icon Container
            Positioned(
              left: 26,
              top: iconContainerTop - cardTop,
              child: Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: isCountryFlag ? const Color(0xFFF5F5F7) : const Color(0xFF375BA4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Icon Image
            Positioned(
              left: 26 + iconLeft,
              top: iconContainerTop - cardTop + iconTop,
              child: SizedBox(
                width: 24,
                height: 24,
                child: Image(
                  image: iconImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Title
            Positioned(
              left: 26,
              top: titleTop - cardTop,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1D1B20),
                ),
              ),
            ),
            // Status Icon (if exists)
            if (statusImage != null)
              Positioned(
                left: 261,
                top: statusIconTop - cardTop,
                child: SizedBox(
                  width: statusIconSize,
                  height: statusIconSize,
                  child: Image(
                    image: statusImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            // Progress Text
            Positioned(
              left: title == 'Preliminary' ? 291 : 287,
              top: progressTop - cardTop,
              child: Text(
                '$progress/$total',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFC7C7C7),
                ),
              ),
            ),
            // Chevron
            Positioned(
              left: title == 'Preliminary' ? 329 : 325,
              top: chevronTop - cardTop,
              child: const Icon(
                Icons.chevron_right,
                color: Color(0xFFC7C7C7),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}