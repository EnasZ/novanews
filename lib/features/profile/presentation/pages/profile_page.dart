import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            final user = state.user;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 56,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=omar'),
                    ),
                  ),
                  const Gap(16),
                  Text(user.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Gap(4),
                  Text(user.email, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                  const Gap(32),
                  _buildProfileCard(context, [
                    _buildInfoRow(Icons.person_outline, "Full Name", user.fullName),
                    const Divider(height: 32),
                    _buildInfoRow(Icons.calendar_today_outlined, "Age", "${user.age} Years"),
                    const Divider(height: 32),
                    _buildInfoRow(Icons.public_outlined, "Country", user.country),
                  ]),
                  const Gap(24),
                  _buildProfileCard(context, [
                    _buildActionRow(context, Icons.edit_outlined, "Edit Profile", () {}),
                    const Divider(height: 32),
                    _buildActionRow(context, Icons.lock_reset_outlined, "Change Password", () => context.push('/change-password')),
                  ]),
                  const Gap(32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red.shade100),
                    ),
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                      context.go('/login');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_rounded, size: 20),
                        Gap(8),
                        Text("Logout"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionRow(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700, size: 22),
          const Gap(16),
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
