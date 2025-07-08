// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tflite_examples/common/constants/color_palette.dart';
import 'package:flutter_tflite_examples/common/constants/font_sizes.dart';
import 'package:flutter_tflite_examples/presentation/pages/home/home_shell.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;
  Animation<double>? _scaleAnimation;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
  }

  void _initializeAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
    _isControllerInitialized = true;
    _animationController!.forward();
  }

  @override
  void dispose() {
    if (_isControllerInitialized) {
      _animationController?.dispose();
    }
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    const teal = ColorPalette.teal;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: FadeTransition(
          opacity: _fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 48 : 24,
                  vertical: isTablet ? 32 : 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: isTablet ? 400 : MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.poppins(
                            color: teal,
                            fontSize: isTablet ? FontSizes.fontSize24 : FontSizes.fontSize20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue',
                          style: GoogleFonts.poppins(
                            color: ColorPalette.grey,
                            fontSize: isTablet ? FontSizes.fontSize16 : FontSizes.fontSize14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: GoogleFonts.poppins(
                              color: ColorPalette.grey,
                              fontSize: isTablet ? FontSizes.fontSize14 : FontSizes.fontSize12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: ColorPalette.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: teal, width: .5),
                            ),
                            prefixIcon: const Icon(Icons.person, color: teal),
                          ),
                          style: GoogleFonts.poppins(
                            color: ColorPalette.black,
                            fontSize: isTablet ? FontSizes.fontSize14 : FontSizes.fontSize12,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: GoogleFonts.poppins(
                              color: ColorPalette.grey,
                              fontSize: isTablet ? FontSizes.fontSize14 : FontSizes.fontSize12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: ColorPalette.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: teal, width: .5),
                            ),
                            prefixIcon: const Icon(Icons.lock, color: teal),
                          ),
                          style: GoogleFonts.poppins(
                            color: ColorPalette.black,
                            fontSize: isTablet ? FontSizes.fontSize14 : FontSizes.fontSize12,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: teal,
                              checkColor: ColorPalette.white,
                            ),
                            Text(
                              'Remember Me',
                              style: GoogleFonts.poppins(
                                color: ColorPalette.black,
                                fontSize: isTablet ? FontSizes.fontSize14 : FontSizes.fontSize12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ScaleTransition(
                          scale: _scaleAnimation ?? const AlwaysStoppedAnimation(1.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: teal,
                              foregroundColor: ColorPalette.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: isTablet ? 16 : 14,
                                horizontal: 24,
                              ),
                              elevation: 2,
                              surfaceTintColor: ColorPalette.white, // Prevent tint shifts
                              minimumSize: Size(double.infinity, isTablet ? 50 : 48),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const HomeMainShell()), (Route <dynamic> route)=> false);
                            },
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.poppins(
                                color: ColorPalette.white,
                                fontSize: isTablet ? FontSizes.fontSize16 : FontSizes.fontSize14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Placeholder for sign-up navigation
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Sign Up tapped',
                                        style: GoogleFonts.poppins(
                                          color: ColorPalette.white,
                                          fontSize: FontSizes.fontSize14,
                                        ),
                                      ),
                                      backgroundColor: teal,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                  color: teal,
                                  fontSize: isTablet ? FontSizes.fontSize14 : FontSizes.fontSize12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
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
        ),
      ),
    );
  }
}