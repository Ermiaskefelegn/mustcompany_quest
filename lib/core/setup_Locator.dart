import 'package:get_it/get_it.dart';
import 'package:mustcompany_quest/features/timer_app/data/datasources/screenshot_service.dart';
import 'package:mustcompany_quest/features/timer_app/data/repositories/timer_repository_impl.dart';
import 'package:mustcompany_quest/features/timer_app/domain/usecases/start_timer.dart';
import 'package:mustcompany_quest/features/timer_app/presentation/bloc/timer_app_bloc.dart';

void setupLocator() {
  final getIt = GetIt.instance;

  // Register services
  getIt.registerSingleton<ScreenshotService>(ScreenshotService());

  // Register repositories
  getIt.registerSingleton<TimerRepositoryImpl>(TimerRepositoryImpl());

  // Register use cases
  getIt.registerSingleton<StartTimer>(StartTimer(getIt<TimerRepositoryImpl>()));

  // Register blocs
  getIt.registerFactory(() => TimerBloc(getIt<StartTimer>()));
}
