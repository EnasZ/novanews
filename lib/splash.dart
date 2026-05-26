import 'dart:async';
import 'package:flutter/material.dart';
import 'package:novanews/core/app_images.dart';
import 'package:novanews/core/theme/app_colors.dart';
import 'package:novanews/core/theme/app_routes.dart';
import 'package:novanews/core/theme/app_styles.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? _navigationTimer;
  double _logoScale = 1.0;

  @override
  void initState() {
    super.initState();
    // مؤقت الانتقال بعد 3 ثوانٍ
    _navigationTimer = Timer(const Duration(seconds: 3), _navigateToHome);
  }

  // دالة الانتقال باستخدام الـ Named Route
  void _navigateToHome() {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTapDown: (_) => setState(() => _logoScale = 1.15),
                    onTapUp: (_) => setState(() => _logoScale = 1.0),
                    onTapCancel: () => setState(() => _logoScale = 1.0),
                    child: AnimatedScale(
                      scale: _logoScale,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutBack,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.15),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image.asset(
                            AppImages.logo,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.primary,
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image, color: AppColors.white, size: 45),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'NovaNews',
                    style: AppStyles.headlineLarge.copyWith(
                      color: AppColors.primaryDark,
                      fontSize: 42,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 30, height: 1, color: AppColors.secondaryLightest),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'THE DAILY REFINED',
                          style: AppStyles.labelLarge.copyWith(
                            color: AppColors.secondaryDark,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                      Container(width: 30, height: 1, color: AppColors.secondaryLightest),
                    ],
                  ),
                ],
              ),
            ),
            
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 60, 
                    height: 3, 
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.secondaryLightest, 
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Executive Editorial Experience',
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}