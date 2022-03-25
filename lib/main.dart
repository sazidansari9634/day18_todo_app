import 'package:day18_todo_app/amplifyconfiguration.dart';
import 'package:day18_todo_app/models/ModelProvider.dart';
import 'package:day18_todo_app/todo_cubit.dart';
import 'package:day18_todo_app/todos_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/ModelProvider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  bool _amplifyConfigured = false;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  get Amplify => null;

  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
            create: (context) => TodoCubit()..getTodos(),
            child: _amplifyConfigured ? TodosView() : LoadingView()));
  }

  void _configureAmplify() async {
    Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));
    try {
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print(e);
    }

    setState(() {
      _amplifyConfigured = true;
    });
  }
}

LoadingView() {}

AmplifyDataStore({required ModelProvider modelProvider}) {}
