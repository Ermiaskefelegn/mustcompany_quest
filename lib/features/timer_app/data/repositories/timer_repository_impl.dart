// data/repositories/timer_repository_impl.dart

import 'package:mustcompany_quest/features/timer_app/domain/repositories/timer_repository.dart';

import 'dart:async';

class TimerRepositoryImpl implements TimerRepository {
  final StreamController<int> _controller = StreamController<int>();
  Timer? _timer;
  int _duration = 0;

  @override
  Stream<int> startTimer() {
    // Start the timer and send duration updates
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _controller.add(_duration++);
    });

    // Return the stream from the controller
    return _controller.stream;
  }

  @override
  void stopTimer() {
    // Stop the timer and close the stream
    _timer?.cancel();
    _controller.close();
    _duration = 0; // Optionally reset duration
  }
}
