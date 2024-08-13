import 'package:flutter/material.dart';
import 'package:quarizm_ui_task/pages/service_details/view.dart';
import 'package:quarizm_ui_task/utils/my_scroll_behavior.dart';

void main() {
  runApp(const QuarizmUiTask());
}

class QuarizmUiTask extends StatelessWidget {
  const QuarizmUiTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quarizm UI Task',
      scrollBehavior: MyScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ServiceDetails(),
    );
  }
}
