// lib/presentation/screens/authentication/login.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/custom_assets/assets.gen.dart';
import '../../../global/controler/auth/login_controler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoginController());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set context after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF1D1B20),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Top Background Image
            Positioned(
              left: -7,
              top: -28,
              child: Container(
                width: 408,
                height: 408,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.globeHand.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Logo
            Positioned(
              left: 0,
              right: 0,
              top: 120,
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.images.splashScreenLogo.path),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Login Section
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: 0,
              right: 0,
              top: viewInsets > 0 ? 0 : 347,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF375BA4),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFFFDFDFD),
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildTextField(
                        controller: controller.emailController,
                        hint: 'Email',
                      ),
                      const SizedBox(height: 20),
                      Obx(() => _buildTextField(
                        controller: controller.passwordController,
                        hint: 'Password',
                        obscureText: controller.obscurePassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFFE7E7E7),
                            size: 16,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      )),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => context.push('/forgetPassword'),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Color(0xFFFDFDFD),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildRememberMeCheckbox(controller),
                      const SizedBox(height: 32),
                      _buildLoginButtonRow(controller),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 52.63,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC7C7C7), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Color(0xFFE7E7E7)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFFE7E7E7),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox(LoginController controller) {
    return Obx(() => Row(
      children: [
        GestureDetector(
          onTap: controller.toggleRememberMe,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: controller.rememberMe.value
                  ? const Color(0xFFF5F5F7)
                  : Colors.transparent,
              border: Border.all(color: const Color(0xFFF5F5F7), width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: controller.rememberMe.value
                ? const Icon(Icons.check, size: 12, color: Color(0xFF375BA4))
                : null,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: controller.toggleRememberMe,
          child: const Text(
            'Remember me',
            style: TextStyle(
              color: Color(0xFFE7E7E7),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildLoginButtonRow(LoginController controller) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => GestureDetector(
            onTap: controller.isLoading.value ? null : controller.handleLogin,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFDFDFD),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: controller.isLoading.value
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF375BA4),
                  ),
                ),
              )
                  : const Text(
                'Log in',
                style: TextStyle(
                  color: Color(0xFF375BA4),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )),
        ),
        const SizedBox(width: 8),
        Image.asset(
          Assets.images.loginScreenFaceIcon.path,
          width: 60,
          height: 60,
        ),
      ],
    );
  }
}