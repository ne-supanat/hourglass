import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../consts/animation_keys.dart';
import '../../gen/assets.gen.dart';
import 'main_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _controller = MainBloc();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _controller,
      child: Builder(builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade100),
                  height: 250,
                  padding: const EdgeInsets.all(36),
                  child: BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      return AnimatedRotation(
                        duration: const Duration(seconds: 5),
                        curve: Curves.ease,
                        turns: state.isRotationIsPositive == null
                            ? 0
                            : 0.03 * (state.isRotationIsPositive! ? 1 : -1),
                        child: RiveAnimation.asset(
                          Assets.animations.anim,
                          animations: const [AnimationKeyNames.animFluid],
                          controllers: [_controller.animcontrollerSand0],
                          onInit: _controller.setupStateMachine,
                        ),
                      );
                    },
                  ),
                ),
                FilledButton(onPressed: _controller.start, child: Text('START')),
                FilledButton(onPressed: _controller.stop, child: Text('STOP')),
                FilledButton(onPressed: _controller.testSend, child: Text('TEST')),
                FilledButton(onPressed: _controller.clearStream, child: Text('CANCEL')),
                // FutureBuilder(
                //     future: _controller.repository.genResponse(),
                //     builder: (context, stream) {
                //       return StreamBuilder(
                //           stream: stream.data,
                //           builder: (context, snapshot) {
                //             print(snapshot.data?['response']);
                //             return Text(snapshot.data['response']);
                //           });
                //     }),
                // StreamBuilder(
                //     stream: _controller.test(), // stream.data,
                //     builder: (context, snapshot) {
                //       print(snapshot);
                //       return Text(snapshot.data ?? '');
                //       // print(snapshot.data?['response']);
                //       // return Text(snapshot.data['response']);
                //     }),
                BlocBuilder<MainBloc, MainState>(
                  // buildWhen: (previous, current) {
                  //   print(previous.text);
                  //   print(current.text);
                  //   return previous.text != current.text;
                  // },
                  builder: (context, state) {
                    return Text(state.text ?? '-');
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
