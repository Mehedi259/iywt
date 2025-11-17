
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Stack(
        children: [
          // Background - Globe Image (Blurred/Dimmed)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1A1A1A),
                  const Color(0xFF2D2D2D),
                  const Color(0xFF1A1A1A),
                ],
              ),
            ),
          ),

          // Login Bottom Sheet
          AnimatedBuilder(
            animation: _slideController,
            builder: (context, child) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    MediaQuery.of(context).size.height *
                        0.75 *
                        _slideAnimation.value,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF5B7FBF),
                            Color(0xFF4A6FA5),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 32.h,
                          ),
                          child: Column(
                            children: [
                              // Drag indicator
                              Container(
                                width: 40.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),

                              SizedBox(height: 40.h),

                              // Login Title
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: 40.h),

                              // Email Field
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: TextField(
                                  controller: _emailController,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16.sp,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 18.h,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // Password Field
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16.sp,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 18.h,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // Register & Forgot Password Row
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // Navigate to register
                                    },
                                    child: Text(
                                      'Register?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.push('/forgetPassword');
                                    },
                                    child: Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 8.h),

                              // Remember Me Checkbox
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value ?? false;
                                        });
                                      },
                                      fillColor:
                                      WidgetStateProperty.resolveWith(
                                              (states) {
                                            if (states
                                                .contains(WidgetState.selected)) {
                                              return Colors.white;
                                            }
                                            return Colors.white.withOpacity(0.3);
                                          }),
                                      checkColor: const Color(0xFF5B7FBF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(4.r),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 32.h),

                              // Login Button & Face ID
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle login
                                        context.go('/home');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                        const Color(0xFF5B7FBF),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.r),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        'Log in',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Container(
                                    width: 56.w,
                                    height: 56.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        // Handle Face ID login
                                      },
                                      icon: Icon(
                                        Icons.face_outlined,
                                        color: Colors.white,
                                        size: 28.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}