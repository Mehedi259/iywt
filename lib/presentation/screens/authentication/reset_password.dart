
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Password validation states
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _newPasswordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  bool get _isPasswordValid =>
      _hasMinLength &&
          _hasUppercase &&
          _hasLowercase &&
          _hasNumber &&
          _hasSpecialChar;

  bool get _canSubmit =>
      _newPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _isPasswordValid;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Back Button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0FE),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: const Color(0xFF5B7FBF),
                        size: 24.sp,
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Title
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Subtitle
                  Text(
                    'Set the new password for your account so you can login and access all the features',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey.shade500,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // New Password Label
                  Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // New Password Field
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _obscureNewPassword,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter new password',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureNewPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF5B7FBF),
                          width: 2,
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Password Requirements
                  _buildPasswordRequirement(
                    'At least 8 characters',
                    _hasMinLength,
                  ),
                  SizedBox(height: 8.h),
                  _buildPasswordRequirement(
                    'Must contain one uppercase letter',
                    _hasUppercase,
                  ),
                  SizedBox(height: 8.h),
                  _buildPasswordRequirement(
                    'Must contain one lowercase letter',
                    _hasLowercase,
                  ),
                  SizedBox(height: 8.h),
                  _buildPasswordRequirement(
                    'Must contain one number',
                    _hasNumber,
                  ),
                  SizedBox(height: 8.h),
                  _buildPasswordRequirement(
                    'Must contain one special character',
                    _hasSpecialChar,
                  ),

                  SizedBox(height: 32.h),

                  // Confirm Password Label
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Confirm Password Field
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Re-enter password',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF5B7FBF),
                          width: 2,
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    validator: (value) {
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 40.h),

                  // Reset Password Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: _canSubmit
                          ? () {
                        if (_formKey.currentState!.validate()) {
                          // Handle password reset
                          context.go('/resetPasswordSuccess');
                        }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B7FBF),
                        disabledBackgroundColor: const Color(0xFFB3C5E0),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          color: isMet ? Colors.green : Colors.grey.shade400,
          size: 18.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: isMet ? Colors.green : Colors.grey.shade600,
            fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}