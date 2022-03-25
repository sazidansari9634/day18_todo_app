import 'dart:core';
import 'package:day18_todo_app/models/ModelProvider.dart';
import 'package:day18_todo_app/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TodoState {}

class LoadingTodos extends TodoState {}

class ListTodosSuccess extends TodoState {
  final List<Todo> todos;
  ListTodosSuccess({required this.todos});
}

class ListTodosFailure extends TodoState {
  final Exception exception;
  ListTodosFailure({required this.exception});
}

class TodoCubit extends Cubit<TodoState> {
  final _todoRepo = TodoRepository();

  TodoCubit() : super(LoadingTodos());

  void getTodos() async {
    if (state is ListTodosSuccess == false) {
      emit(LoadingTodos());
    }
    try {
      final todos = await _todoRepo.getTodos();
      emit(ListTodosSuccess(todos: todos));
    } catch (e) {
      var e;
      emit(ListTodosFailure(exception: e));
    }
  }

  void createTodo(String title) {}

  void updateTodoIsComplete(Todo todo, bool isComplete) {}
}
