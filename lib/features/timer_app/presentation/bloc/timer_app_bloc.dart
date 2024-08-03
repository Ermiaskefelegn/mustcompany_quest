import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustcompany_quest/features/timer_app/domain/usecases/start_timer.dart';

abstract class TimerEvent {}

class Start extends TimerEvent {}

class Stop extends TimerEvent {}

class ScreenshotTaken extends TimerEvent {
  final String filePath;

  ScreenshotTaken(this.filePath);
}

class TimerState {
  final int duration;
  final String? screenshotPath;

  TimerState(this.duration, {this.screenshotPath});
}

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final StartTimer startTimer;
  StreamSubscription<int>? _timerSubscription;

  TimerBloc(this.startTimer) : super(TimerState(0)) {
    on<TimerEvent>((event, emit) async {
      if (event is Start) {
        await for (final duration in startTimer()) {
          emit(TimerState(duration));
        }
      } else if (event is Stop) {
        startTimer.callstop();
        emit(TimerState(state.duration));
      } else if (event is ScreenshotTaken) {
        // Update the state with the screenshot path
        emit(TimerState(state.duration, screenshotPath: event.filePath));
      }
    });
  }

  @override
  Future<void> close() {
    // Cancel the subscription when bloc is closed
    _timerSubscription?.cancel();
    return super.close();
  }
}
