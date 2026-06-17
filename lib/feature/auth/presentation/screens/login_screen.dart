import 'package:flutter/material.dart';
import 'package:novanews/core/theme/app_colors.dart';
import 'package:novanews/core/theme/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. الشعار العلوي والعنوان الفرعي الموحد
                const LoginHeaderLogo(),
                const SizedBox(height: 40),

                // 2. كارت الحاوية البيضاء الرئيسي المماثل للتصميم
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neutralDarkest.withOpacity(0.03),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LoginWelcomeText(),
                        const SizedBox(height: 32),

                        // حقل بريد العمل الإيجاري
                        const FieldLabelText(label: 'Work Email'),
                        const SizedBox(height: 8),
                        LoginInputField(
                          controller: _emailController,
                          hintText: 'name@company.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),

                        // حقل كلمة المرور مع زر استعادة الحساب
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FieldLabelText(label: 'Password'),
                            ForgotPasswordButton(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LoginInputField(
                          controller: _passwordController,
                          hintText: '••••••••',
                          obscureText: true,
                        ),
                        const SizedBox(height: 28),

                        // زر تسجيل الدخول الرئيسي
                        LoginSubmitButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // تنفيذ الدالة عبر الـ Cubit لاحقاً
                            }
                          },
                        ),
                        const SizedBox(height: 28),

                        // خطوط الفصل الجانبية "Or Continue With"
                        const SocialDivider(),
                        const SizedBox(height: 24),

                        // أزرار تسجيل الدخول الاجتماعي (Google & LinkedIn)
                        const SocialLoginRow(),
                        const SizedBox(height: 28),

                        // نص إنشاء حساب جديد السفلي
                        const SignUpNavigationRow(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 3. نصوص الحقوق والخصوصية في تذييل الشاشة
                const LoginFooterCopyrights(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- المكونات الذرية المستخرجة (Extracted Clean Widgets) ---

class LoginHeaderLogo extends StatelessWidget {
  const LoginHeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'NovaNews',
          style: AppStyles.headlineLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            fontSize: 38,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'INTELLIGENCE IN MOTION',
          style: AppStyles.labelMedium.copyWith(
            color: AppColors.secondary.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }
}

class LoginWelcomeText extends StatelessWidget {
  const LoginWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.neutralDarkest,
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Access your personalized briefing.',
          style: AppStyles.bodyMedium.copyWith(
            color: AppColors.secondary,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class FieldLabelText extends StatelessWidget {
  final String label;
  const FieldLabelText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppStyles.labelMedium.copyWith(
        color: AppColors.neutralDarkest.withOpacity(0.8),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Forgot Password?',
        style: AppStyles.labelMedium.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}

class LoginInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  const LoginInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppStyles.bodyMedium.copyWith(color: AppColors.neutralDarkest),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.bodyMedium.copyWith(color: AppColors.secondary.withOpacity(0.4)),
        filled: true,
        fillColor: AppColors.neutralBg.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondary.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondary.withOpacity(0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class LoginSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LoginSubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: AppStyles.bodyLarge.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: AppColors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

class SocialDivider extends StatelessWidget {
  const SocialDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.secondary.withOpacity(0.15), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR CONTINUE WITH',
            style: AppStyles.labelMedium.copyWith(
              color: AppColors.secondary.withOpacity(0.5),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.secondary.withOpacity(0.15), thickness: 1)),
      ],
    );
  }
}

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.secondary.withOpacity(0.2)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Google',
              style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.neutralDarkest),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.secondary.withOpacity(0.2)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'LinkedIn',
              style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.neutralDarkest),
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpNavigationRow extends StatelessWidget {
  const SignUpNavigationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppStyles.bodyMedium.copyWith(color: AppColors.secondary, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Sign Up',
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class LoginFooterCopyrights extends StatelessWidget {
  const LoginFooterCopyrights({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '© 2026 NovaNews Media Group. All rights reserved.',
          style: AppStyles.labelMedium.copyWith(color: AppColors.secondary.withOpacity(0.6), fontSize: 11),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Privacy Policy', style: AppStyles.labelMedium.copyWith(color: AppColors.secondary.withOpacity(0.6), fontSize: 11)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text('•', style: TextStyle(color: AppColors.secondary.withOpacity(0.4))),
            ),
            Text('Terms of Service', style: AppStyles.labelMedium.copyWith(color: AppColors.secondary.withOpacity(0.6), fontSize: 11)),
          ],
        ),
      ],
    );
  }
}