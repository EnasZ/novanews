import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../cubit/settings_cubit.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("General", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                const Gap(16),
                _buildSettingsGroup(context, [
                  _buildSettingSwitch(
                    Icons.dark_mode_outlined,
                    "Dark Mode",
                    state.isDarkMode,
                    (v) => context.read<SettingsCubit>().toggleDarkMode(v),
                  ),
                  const Divider(height: 1),
                  _buildSettingTile(Icons.language_outlined, "Language", state.language, () {}),
                ]),
                const Gap(32),
                const Text("App Info", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                const Gap(16),
                _buildSettingsGroup(context, [
                  _buildSettingTile(Icons.notifications_none_outlined, "Notifications", null, () {}),
                  const Divider(height: 1),
                  _buildSettingTile(Icons.privacy_tip_outlined, "Privacy Policy", null, () {}),
                  const Divider(height: 1),
                  _buildSettingTile(Icons.info_outline, "About NovaNews", "v1.0.0", () {}),
                ]),
                const Gap(40),
                _buildLogoutButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String? trailing, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) Text(trailing, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const Gap(8),
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildSettingSwitch(IconData icon, String title, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Icon(icon, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      trailing: Switch.adaptive(
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthCubit>().logout();
        context.go('/login');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withOpacity(0.1)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: Colors.red, size: 20),
            Gap(8),
            Text("Sign Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
