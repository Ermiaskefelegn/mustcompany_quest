import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:mockito/annotations.dart';
import 'package:mustcompany_quest/features/timer_app/domain/usecases/start_timer.dart';
import 'package:mustcompany_quest/features/timer_app/presentation/bloc/timer_app_bloc.dart';

import 'timer_bloc_test.mocks.dart';

@GenerateMocks([StartTimer])
void main() {
  group('TimerBloc', () {
    late MockStartTimer mockStartTimer;

    setUp(() {
      mockStartTimer = MockStartTimer();
    });

    blocTest<TimerBloc, TimerState>(
      'emits [TimerState(0), TimerState(1), TimerState(2)] when started and stops',
      build: () {
        when(mockStartTimer.call()).thenAnswer((_) =>
            Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(5));
        return TimerBloc(mockStartTimer);
      },
      act: (bloc) async {
        bloc.add(Start());
        await Future.delayed(
            const Duration(seconds: 2)); // Wait for some emissions
        bloc.add(Stop()); // Stop the timer
      },
      wait: const Duration(seconds: 3),
      expect: () => [
        TimerState(0),
        TimerState(1),
        TimerState(2),
        TimerState(2), // Ensure it does not change after stopping
      ],
    );
  });
}
