import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/config/routes/routes.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/assets_path.dart';
import 'package:task_management/helpers/helper_snackbar.dart';
import 'package:task_management/screens/canceled/view/canceled_screen.dart';
import 'package:task_management/screens/completed/view/completed_screen.dart';
import 'package:task_management/screens/new_task/view/new_task_screen.dart';
import 'package:task_management/screens/progress/view/progress_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final pages = [
    const NewTaskScreen(),
    const CompletedScreen(),
    const CanceledScreen(),
    const ProgressScreen()
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(textTheme),
        bottomNavigationBar: _buildNavigationBar(),
        body: pages[currentIndex],
      ),
    );
  }

  NavigationBar _buildNavigationBar() {
    return NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(Icons.task_outlined),
              icon: Icon(Icons.task),
              label: "New Task"),
          NavigationDestination(
              selectedIcon: Icon(Icons.task_outlined),
              icon: Icon(Icons.task),
              label: "Completed"),
          NavigationDestination(
              selectedIcon: Icon(Icons.task_outlined),
              icon: Icon(Icons.task),
              label: "Canceled"),
          NavigationDestination(
              selectedIcon: Icon(Icons.task_outlined),
              icon: Icon(Icons.task),
              label: "Progress")
        ]);
  }

  AppBar _buildAppBar(TextTheme textTheme) {
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
          style: textTheme.titleSmall?.copyWith(color: AppColors.colorWhite),
        ),
        leading: const CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.colorGreen,
          backgroundImage: AssetImage(AssetsPath.avater),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signIn,
              (route) => false,
            );
            HelperSnackbar.showSnackBar(
              context: context,
              message: "Logout Success",
              backgroundColor: AppColors.colorGreen,
            );
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.clear();
          },
          icon: const Icon(Icons.logout_outlined),
        )
      ],
    );
  }
}
