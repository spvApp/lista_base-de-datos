import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/pages/save_page.dart';
import 'package:todoapp/todos_bloc.dart';

class ListPage extends StatefulWidget {
  static const String ROUTE = "/";

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List<Todo> todos;
  late TodosBloc todosBloc;

  @override
  void initState() {
    todosBloc = TodosBloc();
    super.initState();
  }

  @override
  void dispose() {
    todosBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    todos = todosBloc.todosList;

    return Scaffold(
        appBar: AppBar(
          title: Text("Listado"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, SavePage.ROUTE);
          },
        ),
        body: StreamBuilder(
          stream: todosBloc.todosStream,
          initialData: [todos],
          builder: (_, AsyncSnapshot snapshot) {
            return ListView.builder(
                itemCount: snapshot.hasData ? snapshot.data.length : 0,
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: Key(snapshot.data[index].id.toString()),
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: snapshot.data[index].priority >= 5
                              ? Colors.red
                              : Colors.yellow,
                          child: Text(
                            "${snapshot.data[index].priority}",
                            style: TextStyle(color: Colors.white),
                          )),
                      title: Text("${snapshot.data[index].name}"),
                      subtitle: Text("${snapshot.data[index].description}"),
                      trailing: GestureDetector(
                        child: Icon(Icons.edit),
                        onTap: () {
                          Navigator.pushNamed(context, SavePage.ROUTE,
                              arguments: snapshot.data[index]);
                        },
                      ),
                    ),
                    onDismissed: (_) {
                      todosBloc.todoDeleteSink.add(snapshot.data[index]);
                    },
                  );
                });
          },
        ));
  }
}
