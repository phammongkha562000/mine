import 'package:bmi_pj/utils/extensions.dart';
import 'package:bmi_pj/widgets/common_container.dart';
import 'package:bmi_pj/widgets/display_white_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Container(
              height: deviceSize.height * 0.3,
              width: deviceSize.width,
              color: colors.primary,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DisplayWhiteText(
                    text: 'Jan 9, 2024',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  Gap(10),
                  DisplayWhiteText(text: 'My Todo List', fontSize: 30),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CommonContainer(
                    height: deviceSize.height * 0.3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) {
                        return const Text('Home');
                      },
                      itemCount: 10,
                    ),
                  ),
                  Gap(20),
                  Text(
                    'Completed',
                    style: context.textTheme.headlineMedium,
                  ),
                  Gap(20),
                  CommonContainer(
                    height: deviceSize.height * 0.2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) {
                        return const Text('Home');
                      },
                      itemCount: 10,
                    ),
                  ),
                  Gap(20),
                  ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DisplayWhiteText(
                          text: 'Add New Task',
                          fontSize: 16,
                        ),
                      ))
                ],
              ),
            ))
      ],
    ));
  }
}
