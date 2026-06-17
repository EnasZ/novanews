import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/news-feed'); // Navigate to News Feed after successful login
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Icon(Icons.newspaper_rounded, size: 64, color: AppColors.primary),
                        Gap(12),
                        Text(
                          "NovaNews",
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const Gap(48),
                  const Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const Gap(8),
                  Text("Enter your credentials to access your account", style: TextStyle(color: Colors.grey.shade600)),
                  const Gap(32),
                  CustomTextField(
                    controller: _emailController,
                    label: "Email",
                    icon: Icons.email_outlined,
                    validator: (v) => (v == null || !v.contains('@')) ? "Invalid email" : null,
                  ),
                  const Gap(20),
                  CustomTextField(
                    controller: _passwordController,
                    label: "Password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    validator: (v) => (v == null || v.length < 6) ? "Password too short" : null,
                  ),
                  const Gap(12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?", style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const Gap(24),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(_emailController.text, _passwordController.text);
                          }
                        },
                        child: const Text("Sign In"),
                      );
                    },
                  ),
                  const Gap(32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: TextStyle(color: Colors.grey.shade600)),
                      TextButton(
                        onPressed: () => context.push('/register'),
                        child: const Text("Create Account", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
