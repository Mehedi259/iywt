import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Added missing import
import 'package:iywt/core/routes/routes.dart';
import '../../../core/custom_assets/assets.gen.dart';
import '../../../core/routes/route_path.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool get _isButtonEnabled => _emailController.text.isNotEmpty;

  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      // Handle password reset logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent to your email!'),
          backgroundColor: Color(0xFF375BA4),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate after a short delay to show the snackbar
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.go(RoutePath.login.addBasePath);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Back Button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Assets.images.backIcon.image(
                    width: 44,
                    height: 44,
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                const Text(
                  'Forgot password',
                  style: TextStyle(
                    color: Color(0xFF1D1B20),
                    fontSize: 18,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.50,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                const Text(
                  'Please enter your email to reset the password',
                  style: TextStyle(
                    color: Color(0xFFC7C7C7),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                    letterSpacing: -0.50,
                  ),
                ),

                const SizedBox(height: 36),

                // Email Label
                const Text(
                  'Your Email',
                  style: TextStyle(
                    color: Color(0xFF1D1B20),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 18),

                // Email Input Field
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.50,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        color: Color(0xFFC7C7C7),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.50,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFC7C7C7),
                          width: 0.50,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF375BA4),
                          width: 1.0,
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 0.50,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 12, right: 8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 57),

                // Reset Password Button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled ? _handleResetPassword : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF375BA4),
                      disabledBackgroundColor: const Color(0x7F375BA4),
                      foregroundColor: const Color(0xFFFDFDFD),
                      disabledForegroundColor: const Color(0xFFFDFDFD),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF375BA4),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}