import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/common/logic/list_task_by_status_controller.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/new_task/controller/new_task_controller.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskController newTaskController = Get.put(NewTaskController());
  final ListTaskByStatusController listTaskByStatusController =
      Get.put(ListTaskByStatusController());

  @override
  void initState() {
    super.initState();
    listTaskByStatusController.getTaskByStatus(status: "New");
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AppBackground(
          child: Obx(
        () => listTaskByStatusController.isProgress.value
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.colorGreen,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _buildProgressHeaderSection(textTheme),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTaskListSection(textTheme)
                  ],
                ),
              ),
      )),
      floatingActionButton:
          BuildCreateNewTaskFlotButton(newTaskController: newTaskController),
    );
  }

  Expanded _buildTaskListSection(TextTheme textTheme) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          separatorBuilder: (context, index) {
            final task = listTaskByStatusController.taskList[index];
            final DateTime dateTime = DateTime.parse(task["createdDate"]);
            final String formattedDate =
                DateFormat("dd-MMM-yyyy").format(dateTime);
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: AppColors.colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["title"].isNotEmpty ? task["title"] : "N/A"}",
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${task["description"].isNotEmpty ? task["description"] : "N/A"}",
                      style: textTheme.titleSmall?.copyWith(
                          color: AppColors.colorLightGray,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Date : $formattedDate",
                      style: textTheme.titleSmall?.copyWith(
                          color: AppColors.colorDarkBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.colorBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () {},
                            child: Text(
                              "${task["status"].isNotEmpty ? task["status"] : "N/A"}",
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit_off_outlined,
                                  color: AppColors.colorGreen,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete_forever_sharp,
                                  color: AppColors.colorRed,
                                ))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: listTaskByStatusController.taskList.length),
    );
  }

  Row _buildProgressHeaderSection(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProgressSection(
            textTheme: textTheme,
            progressCount: "09",
            progressName: "New Task"),
        const SizedBox(
          width: 5,
        ),
        _buildProgressSection(
            textTheme: textTheme,
            progressCount: "09",
            progressName: "Completed"),
        const SizedBox(
          width: 5,
        ),
        _buildProgressSection(
            textTheme: textTheme,
            progressCount: "09",
            progressName: "Canceled"),
        const SizedBox(
          width: 5,
        ),
        _buildProgressSection(
            textTheme: textTheme, progressCount: "09", progressName: "Progress")
      ],
    );
  }

  Expanded _buildProgressSection(
      {required TextTheme textTheme,
      required String progressCount,
      required String progressName}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              progressCount,
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              progressName,
              style: textTheme.titleSmall?.copyWith(
                  color: AppColors.colorLightGray,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}

class BuildCreateNewTaskFlotButton extends StatelessWidget {
  const BuildCreateNewTaskFlotButton({
    super.key,
    required this.newTaskController,
  });

  final NewTaskController newTaskController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed: () => newTaskController.goToCreateNewTask(),
      backgroundColor: AppColors.colorGreen,
      child: const Icon(
        Icons.add,
        color: AppColors.colorWhite,
      ),
    );
  }
}
