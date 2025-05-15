import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/core/resources/assets_manager.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/cubits/local_cubit/local_cubit.dart';
import '../../../../core/l10n/app_localizations.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LocalizationCubit.get(context);
    var lang = AppLocalizations.of(context);
    print(UserModel.instance.token);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            _buildHeader(context, lang!),
            const SizedBox(height: 20),
            _buildClickableTile(
              context,
              icon: const Icon(Icons.assignment_outlined),
              label: lang.myOrders,
              onTap: () {
                // Navigate to orders
              },
            ),
            _buildClickableTile(
              context,
              icon: const Icon(Icons.location_on_outlined),
              label: lang.savedAddress,
              onTap: () {
                Navigator.pushNamed(context, Routes.savedAddress);
              },
            ),
            const Divider(height: 32),
            _buildSwitchTile(
              context,
              label: lang.notification,
              value: true,
              onChanged: (val) {},
            ),
            const Divider(height: 32),
            _buildClickableTile(
              context,
              icon: const Icon(Icons.sort_by_alpha),
              label: lang.lang,
              trailing: Text(
                cubit.state.language == "ar" ? "عربى" : "English",
                style: const TextStyle(color: Colors.pink),
              ),
              onTap: () {
                showLanguageBottomSheet(
                  context,
                  cubit,
                  Text(
                    cubit.state.language == "ar"
                        ? "تغيير اللغة"
                        : "Change Language",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                );
              },
            ),
            _buildClickableTile(
              context,
              icon: const Icon(Icons.info_outline),
              label: lang.aboutUs,
              onTap: () {
                Navigator.pushNamed(context, Routes.aboutUs);
              },
            ),
            _buildClickableTile(
              context,
              icon: const Icon(Icons.description_outlined),
              label: lang.termsAndConditions,
              onTap: () {
                Navigator.pushNamed(context, Routes.termsConditions);
              },
            ),
            const Divider(height: 32),
            _buildClickableTile(
              context,
              icon: const Icon(Icons.logout),
              label: lang.logout,
              onTap: () {
                showLogoutDialog(context, () async {
                  const storage = FlutterSecureStorage();
                 await storage.delete(key: 'user_token');
                 UserModel.instance.token = null;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.loginRoute,
                    (route) => false,
                  );
                }, lang);
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations lang) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(ImageAssets.flower),
            SizedBox(width: 5.w),
            Image.asset(ImageAssets.flowery),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Badge.count(count: 3, child: Icon(Icons.notifications)),
            ),
          ],
        ), // Replace with your asset
        const SizedBox(height: 10),
        const CircleAvatar(
          radius: 40,
          // backgroundImage: NetworkImage("https://your-image-url.com/image.jpg"),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lang.editProfile,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.changePasswordRoute);
              },
              child: Image.asset('assets/images/edit.png', height: 50.h),
            ),
          ],
        ),
        Text(
          UserModel.instance.email??"Guest",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildClickableTile(
    BuildContext context, {
    required Widget icon,
    required String label,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: icon,
      title: Text(label),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      title: Text(label),
      leading: Switch(
        value: value,
        activeColor: Colors.white,
        activeTrackColor: Colors.pink,
        onChanged: onChanged,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  void showLanguageBottomSheet(BuildContext context, cubit, Widget title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [title]),
              const SizedBox(height: 16),
              _buildLanguageOption(
                context,
                label: 'English',
                value: 'en',
                groupValue: cubit.state.language,
                onChanged: (val) {
                  cubit.changeLanguage(val);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              _buildLanguageOption(
                context,
                label: 'عربى',
                value: 'ar',
                groupValue: cubit.state.language,
                onChanged: (val) {
                  cubit.changeLanguage(val);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String label,
    required String value,
    required String groupValue,
    required Function(String) onChanged,
  }) {
    final bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              activeColor: Colors.pink,
              onChanged: (val) => onChanged(val!),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutDialog(
    BuildContext context,
    VoidCallback onConfirmLogout,
    AppLocalizations lang,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Center(
            child: Text(
              lang.logout,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          content: Text(lang.confirmLogout, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(lang.cancel, style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                onConfirmLogout(); // Call your logout function
              },
              child: Text(lang.logout, style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
