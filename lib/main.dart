// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mustcompany_quest/core/setup_Locator.dart';
import 'package:mustcompany_quest/features/timer_app/presentation/bloc/timer_app_bloc.dart';
import 'package:mustcompany_quest/features/timer_app/presentation/pages/timer_screen.dart';

void main() {
  setupLocator();
  runApp(const TimerApp());
}

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => GetIt.instance<TimerBloc>(),
        child: TimerScreen(),
      ),
    );
  }
}
