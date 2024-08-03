// domain/usecases/start_timer.dart
import 'package:mustcompany_quest/features/timer_app/domain/repositories/timer_repository.dart';

class StartTimer {
  final TimerRepository repository;

  StartTimer(this.repository);

  Stream<int> call() {
    return repository.startTimer();
  }

  void callstop() {
    repository.stopTimer();
  }
}
