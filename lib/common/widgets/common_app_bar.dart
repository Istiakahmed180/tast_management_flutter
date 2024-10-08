import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/logic/auth_controller.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/assets_path.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.colorGreen,
      title: ListTile(
        title: Text(
          "Istiak Ahmed",
          style: textTheme.titleLarge?.copyWith(color: AppColors.colorWhite),
        ),
        subtitle: Text(
          "Istiakahmed180@gmail.com",
          style: textTheme.titleSmall
              ?.copyWith(color: AppColors.colorWhite, fontSize: 14),
        ),
        leading: const CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.colorGreen,
          backgroundImage: AssetImage(AssetsPath.avater),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => authController.logout(),
          icon: const Icon(Icons.logout_outlined),
        )
      ],
    );
  }
}
