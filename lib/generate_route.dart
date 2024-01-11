import 'package:bmi_pj/constants/route_paths.dart' as route;
import 'package:bmi_pj/constants/strings.dart' as strings;
import 'package:bmi_pj/presentations/screens/bmi_view.dart';
import 'package:bmi_pj/presentations/screens/todo_list_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case route.bmiRoute:
      return MaterialPageRoute(
        builder: (context) => const BMIView(),
      );

      case route.todoListRoute:
      return MaterialPageRoute(
        builder: (context) => const TodoListView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold( 
          body: Center(child: Text('${strings.noPath} ${settings.name}')),
        ),
      );
  }
}
