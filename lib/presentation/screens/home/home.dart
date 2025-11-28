import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iywt/core/routes/routes.dart';
import '../../../core/routes/route_path.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _legalEntryController;
  late AnimationController _ticketingController;
  late Animation<double> _legalEntryAnimation;
  late Animation<double> _ticketingAnimation;

  @override
  void initState() {
    super.initState();

    // Legal Entry Animation Controller (50%)
    _legalEntryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _legalEntryAnimation = Tween<double>(
      begin: 0.0,
      end: 0.50,
    ).animate(CurvedAnimation(
      parent: _legalEntryController,
      curve: Curves.easeOutCubic,
    ));

    // Ticketing Animation Controller (80%)
    _ticketingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _ticketingAnimation = Tween<double>(
      begin: 0.0,
      end: 0.80,
    ).animate(CurvedAnimation(
      parent: _ticketingController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations with a slight delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _legalEntryController.forward();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _ticketingController.forward();
    });
  }

  @override
  void dispose() {
    _legalEntryController.dispose();
    _ticketingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Kyle Barnes',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    /// Notification Button with Asset Image
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F0FE),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/notifications.png',
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () => context.go(RoutePath.notification.addBasePath),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// LEGAL ENTRY PROGRESS CARD (50%)
                AnimatedBuilder(
                  animation: _legalEntryAnimation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    value: _legalEntryAnimation.value,
                                    strokeWidth: 8,
                                    backgroundColor: const Color(0xFFE0E0E0),
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF5B7FBF),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 39,
                                  height: 21,
                                  child: Text(
                                    '50%',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF375BA4) /* Primary */,
                                      fontSize: 18,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 1.44,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),

                          /// TEXTS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Legal Entry Progress',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5B7FBF),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Visa application submitted. Awaiting approval from immigration office.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// TICKETING PROGRESS CARD (80%)
                AnimatedBuilder(
                  animation: _ticketingAnimation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    value: _ticketingAnimation.value,
                                    strokeWidth: 8,
                                    backgroundColor: const Color(0xFFE0E0E0),
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF5B7FBF),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 39,
                                  height: 21,
                                  child: Text(
                                    '80%',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF375BA4) /* Primary */,
                                      fontSize: 18,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 1.44,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ticketing Progress',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5B7FBF),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Flight tickets booked for September 28th, 2025. Confirmation sent.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// DEADLINE CARD with Alert Icon
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8E8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Documents Upload Deadline: 28 JUL 2025',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// MESSAGE BOARD TITLE
                const Text(
                  'Message Board',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20),

                /// MESSAGE CARD with Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/massages.png',
                            width: 28,
                            height: 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Messages',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Text(
                            'You have ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '4',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            ' unread messages.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => context.push(RoutePath.massageScreen.addBasePath),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5B7FBF),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'View Messages',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 0),
    );
  }
}