// lib/global/controller/auth/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as developer;
import '../../service/auth/login_service.dart';

class LoginController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final rememberMe = false.obs;

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // BuildContext reference for navigation and snackbar
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// Toggle remember me
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  /// Show SnackBar
  void _showSnackBar(String message, {bool isError = false}) {
    if (_context == null || !_context!.mounted) return;

    ScaffoldMessenger.of(_context!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Validate input
  bool _validateInput() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      _showSnackBar('Please enter your email', isError: true);
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      _showSnackBar('Please enter a valid email', isError: true);
      return false;
    }

    if (password.isEmpty) {
      _showSnackBar('Please enter your password', isError: true);
      return false;
    }

    return true;
  }

  /// Handle login
  Future<void> handleLogin() async {
    if (!_validateInput()) return;
    if (_context == null || !_context!.mounted) return;

    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      developer.log('🚀 Login attempt started', name: 'LoginController');

      final result = await LoginService.login(
        email: email,
        password: password,
      );

      if (result['success'] == true) {
        developer.log('✅ Login successful', name: 'LoginController');

        _showSnackBar('Login successful!', isError: false);

        // Wait a moment for snackbar to show, then navigate
        await Future.delayed(const Duration(milliseconds: 500));

        // Navigate to home using GoRouter
        if (_context != null && _context!.mounted) {
          _context!.go('/home');
        }
      } else {
        developer.log('❌ Login failed: ${result['error']}', name: 'LoginController');
        _showSnackBar(
          result['error'] ?? 'Invalid credentials',
          isError: true,
        );
      }
    } catch (e) {
      developer.log('❌ Login error: $e', name: 'LoginController');
      _showSnackBar(
        'An error occurred. Please try again.',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}