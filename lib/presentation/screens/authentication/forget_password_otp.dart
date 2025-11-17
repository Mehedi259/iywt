import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  int _secondsRemaining = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      }
    });
  }

  void _resendOTP() {
    if (_canResend) {
      // Handle resend OTP logic here
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP resent successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String get _timerText {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get _isOtpComplete {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  String get _otpCode {
    return _otpControllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                'OTP Verification',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 12.h),

              // Subtitle
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey.shade500,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(text: 'Enter the verification code we just sent on your email address '),
                    TextSpan(
                      text: 'contact@dscodetech.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // OTP Input Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return _buildOtpBox(index);
                }),
              ),

              SizedBox(height: 40.h),

              // Timer and Resend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_canResend) ...[
                    Icon(
                      Icons.access_time,
                      color: Colors.grey.shade500,
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _timerText,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Didn't receive code? ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    GestureDetector(
                      onTap: _resendOTP,
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFF5B7FBF),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFF5B7FBF),
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              SizedBox(height: 40.h),

              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _isOtpComplete
                      ? () {
                    // Handle OTP verification
                    print('OTP: $_otpCode');
                    context.push('/resetPassword');
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
                    'Verify',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _otpControllers[index].text.isEmpty
              ? Colors.grey.shade300
              : const Color(0xFF5B7FBF),
          width: 2,
        ),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          setState(() {});
          if (value.isNotEmpty) {
            // Move to next field
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              // Last field, unfocus
              _focusNodes[index].unfocus();
            }
          } else {
            // Move to previous field if deleted
            if (index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          }
        },
        onTap: () {
          // Clear the field when tapped
          _otpControllers[index].clear();
        },
      ),
    );
  }
}
