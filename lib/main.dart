import 'package:flutter/material.dart';
import 'package:todoapp/helpers/todo_db.dart';
import 'package:todoapp/pages/list_page.dart';
import 'package:todoapp/pages/save_page.dart';
import 'package:todoapp/models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TodoDb todoDb = TodoDb();
  await todoDb.initDB();
  await todoDb.database;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      initialRoute: ListPage.ROUTE,
      routes: {
        ListPage.ROUTE: (_) => ListPage(),
        SavePage.ROUTE: (_) => SavePage(),
      },
    );
  }
}
