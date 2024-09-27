import 'package:flutter/material.dart';
import 'package:task_management/common/widgets/app_background.dart';
import 'package:task_management/constants/app_colors.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBackground(
        child: Padding(
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
    ));
  }

  Expanded _buildTaskListSection(TextTheme textTheme) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
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
                      "Lorem Ipsum is simply dummy",
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "It is a long astablashod fact that a reader will be distrapclod by the readeble.",
                      style: textTheme.titleSmall?.copyWith(
                          color: AppColors.colorLightGray,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Date : 02/02/2024",
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
                            child: const Text(
                              "New",
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
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: 20),
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
