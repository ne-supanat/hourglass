import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../consts/animation_keys.dart';

class MainState {
  final bool isRunning;
  final bool? isRotationIsPositive;

  MainState({required this.isRunning, required this.isRotationIsPositive});

  factory MainState.i() {
    return MainState(
      isRunning: false,
      isRotationIsPositive: true,
    );
  }

  copyWith({bool? isRunning, bool? isRotationIsPositive}) {
    return MainState(
      isRunning: isRunning ?? this.isRunning,
      isRotationIsPositive: isRotationIsPositive ?? this.isRotationIsPositive,
    );
  }
}

class MainBloc extends Cubit<MainState> {
  MainBloc() : super(MainState.i());

  late StateMachineController stateControllerFace;

  late RiveAnimationController animcontrollerSand0;

  SMITrigger? _sleep;
  SMITrigger? _wake;

  bool isRunning = false;

  Timer? rotationTimer;

  init() {
    runTimerRotation();

    animcontrollerSand0 = OneShotAnimation(
      AnimationKeyNames.animSandRunning,
      autoplay: false,
      onStop: () {
        animcontrollerSand0.isActive = isRunning;
      },
    );
  }

  dispose() {
    stateControllerFace.dispose();
    animcontrollerSand0.dispose();
  }

  runTimerRotation() {
    final newState = state.copyWith(isRotationIsPositive: !(state.isRotationIsPositive ?? true));
    emit(newState);

    rotationTimer?.cancel();

    rotationTimer = Timer(const Duration(seconds: 2), () {
      runTimerRotation();
    });
  }

  setupStateMachine(Artboard artboard) {
    stateControllerFace = StateMachineController.fromArtboard(artboard, AnimationKeyNames.stateFace)
        as StateMachineController;

    artboard.addController(stateControllerFace);

    _sleep = stateControllerFace.findInput<bool>(AnimationKeyNames.inputSleep) as SMITrigger;
    _wake = stateControllerFace.findInput<bool>(AnimationKeyNames.inputAwake) as SMITrigger;
  }

  start() async {
    _wake?.fire();

    isRunning = true;

    animcontrollerSand0.isActive = true;
  }

  stop() {
    _sleep?.fire();

    isRunning = false;
  }
}
