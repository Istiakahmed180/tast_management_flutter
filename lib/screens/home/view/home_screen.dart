import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/exit_confirmation_alert_dialog.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/assets_path.dart';
import 'package:task_management/screens/canceled/view/canceled_screen.dart';
import 'package:task_management/screens/completed/view/completed_screen.dart';
import 'package:task_management/screens/new_task/view/new_task_screen.dart';
import 'package:task_management/screens/progress/view/progress_screen.dart';
import 'package:task_management/screens/sign_in/controller/sign_in_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SignInController signInController = Get.put(SignInController());
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

    return WillPopScope(
      onWillPop: () {
        return _showExitConfirmationAlertDialog(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(textTheme),
          bottomNavigationBar: _buildNavigationBar(),
          body: pages[currentIndex],
        ),
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
          onPressed: () => signInController.logOut(),
          icon: const Icon(Icons.logout_outlined),
        )
      ],
    );
  }

  Future<bool> _showExitConfirmationAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const ExitConfirmationAlertDialog(),
    ).then((value) => value ?? false);
  }
}
