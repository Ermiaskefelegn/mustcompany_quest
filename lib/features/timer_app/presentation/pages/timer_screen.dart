// presentation/pages/timer_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustcompany_quest/features/timer_app/data/datasources/screenshot_service.dart';
import 'package:mustcompany_quest/features/timer_app/presentation/bloc/timer_app_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mustcompany_quest/features/timer_app/presentation/widgets/image_display_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final GlobalKey _globalKey = GlobalKey();
  String? _screenshotPath;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Timer App')),
      body: Stack(
        children: [
          BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
            print(state.screenshotPath);
            return RepaintBoundary(
              key: _globalKey,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width / 40,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width / 25, vertical: height / 40),
                height: height,
                width: width,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Time: ${state.duration}'),

                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<TimerBloc>(context).add(Start());
                              GetIt.I<ScreenshotService>()
                                  .captureScreenshot(_globalKey, (filePath) {
                                setState(() {
                                  _screenshotPath = filePath;
                                });
                                BlocProvider.of<TimerBloc>(context)
                                    .add(ScreenshotTaken(filePath));
                              });
                            },
                            child: const Text('Start Timer'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<TimerBloc>(context).add(Stop());
                            },
                            child: const Text('Stop Timer'),
                          ),
                          // Add code to display captured screenshot
                        ]),
                    SizedBox(
                      width: width / 2,
                      child: const Text(
                        "Screenshot Will Be Display Here Once Timer starts",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
            );
          }),
          if (_screenshotPath != null) ...[
            const SizedBox(height: 20),
            ImageDisplayWidget(
              imagePath: _screenshotPath!,
              title: 'Screenshot',
            ),
          ],
        ],
      ),
    );
  }
}
