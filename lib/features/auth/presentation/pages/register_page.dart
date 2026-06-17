import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../../data/models/user_model.dart';
import '../../../../core/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Create Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const Gap(8),
                Text("Join NovaNews to get the latest updates", style: TextStyle(color: Colors.grey.shade600)),
                const Gap(32),
                CustomTextField(
                  controller: _nameController,
                  label: "Full Name",
                  icon: Icons.person_outline,
                  validator: (v) => (v == null || v.isEmpty) ? "Name required" : null,
                ),
                const Gap(20),
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
                const Gap(20),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  validator: (v) => (v != _passwordController.text) ? "Passwords don't match" : null,
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
                          final user = UserModel(
                            fullName: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          context.read<AuthCubit>().register(user);
                        }
                      },
                      child: const Text("Create Account"),
                    );
                  },
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: Colors.grey.shade600)),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
