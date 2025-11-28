import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/custom_assets/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  Widget _buildRememberMeCheckbox() {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: _rememberMe ? const Color(0xFFF5F5F7) : Colors.transparent,
            border: Border.all(color: const Color(0xFFF5F5F7), width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: _rememberMe
              ? const Icon(Icons.check, size: 12, color: Color(0xFF375BA4))
              : null,
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              _rememberMe = _rememberMe;
            });
          },
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
    );
  }

  Widget _buildLoginButtonRow() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.go('/home'),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFDFDFD),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Log in',
                style: TextStyle(
                  color: Color(0xFF375BA4),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom; // Keyboard height
    final screenHeight = MediaQuery.of(context).size.height;

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
              top: viewInsets > 0 ? 0 : 347, // Move up when keyboard opens
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
                      _buildTextField(controller: _emailController, hint: 'Email'),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _passwordController,
                        hint: 'Password',
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFFE7E7E7),
                            size: 16,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
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
                      _buildRememberMeCheckbox(),
                      const SizedBox(height: 32),
                      _buildLoginButtonRow(),
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
}
