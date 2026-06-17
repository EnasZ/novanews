import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/theme/app_theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password updated successfully"), backgroundColor: AppColors.success),
            );
            context.pop();
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Change Password", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Gap(8),
                Text("Ensure your account is using a long, random password to stay secure.", style: TextStyle(color: Colors.grey.shade600)),
                const Gap(32),
                CustomTextField(
                  controller: _currentPasswordController,
                  label: "Current Password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
                ),
                const Gap(20),
                CustomTextField(
                  controller: _newPasswordController,
                  label: "New Password",
                  icon: Icons.lock_reset_outlined,
                  isPassword: true,
                  validator: (v) => (v == null || v.length < 6) ? "Too short" : null,
                ),
                const Gap(20),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm New Password",
                  icon: Icons.check_circle_outline,
                  isPassword: true,
                  validator: (v) => (v != _newPasswordController.text) ? "Passwords don't match" : null,
                ),
                const Gap(40),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().changePassword(
                                _currentPasswordController.text,
                                _newPasswordController.text,
                              );
                        }
                      },
                      child: const Text("Update Password"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
