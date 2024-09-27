import 'package:flutter/material.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/assets_path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(textTheme),
        bottomNavigationBar: NavigationBar(
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
            ]),
      ),
    );
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
    );
  }
}
