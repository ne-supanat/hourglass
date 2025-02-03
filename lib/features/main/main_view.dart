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
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _controller,
      child: Builder(builder: (context) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
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
                  FilledButton(
                      onPressed: () {
                        _controller.toFeelingWheel(context);
                      },
                      child: Text('TAROT')),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
