import 'package:day18_todo_app/models/Todo.dart';
import 'package:day18_todo_app/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_view.dart';

class TodosView extends StatefulWidget {
  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _navBar(),
      floatingActionButton: _floatingActionButton(),
      body: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
        if (state is ListTodosSuccess) {
          return state.todos.isEmpty
              ? _emptyTodosView()
              : _todosListView(state.todos);
        } else if (state is ListTodosFailure) {
          return _exceptionView(state.exception);
        } else {
          return LoadingView();
        }
      }),
    );
  }

  Widget _exceptionView(Exception exception) {
    return Center(child: Text(exception.toString()));
  }

  AppBar _navBar() {
    return AppBar(
      title: Text('Todos'),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('show new todo sheet');
        });
  }

  Widget _emptyTodosView() {
    return Center(
      child: Text('No Todos yet'),
    );
  }

  Widget _todosListView(List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Card(
          child: CheckboxListTile(
              value: todo.isComplete, onChanged: (newValue) {}),
        );
      },
    );
  }
}
