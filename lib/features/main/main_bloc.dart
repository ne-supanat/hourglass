import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hourglass/data/repository.dart';
import 'package:rive/rive.dart';

import '../../consts/animation_keys.dart';
import '../../data/usecases/test_gen_usecase.dart';

class MainState {
  final bool isRunning;
  final bool? isRotationIsPositive;
  final String? text;

  MainState({required this.isRunning, required this.isRotationIsPositive, this.text});

  factory MainState.i() {
    return MainState(
      isRunning: false,
      isRotationIsPositive: true,
    );
  }

  copyWith({bool? isRunning, bool? isRotationIsPositive, String? text}) {
    return MainState(
      isRunning: isRunning ?? this.isRunning,
      isRotationIsPositive: isRotationIsPositive ?? this.isRotationIsPositive,
      text: text ?? this.text,
    );
  }
}

class MainBloc extends Cubit<MainState> {
  MainBloc() : super(MainState.i());

  // final TestGenUsecase _genUsecase = TestGenUsecase();
  final Repository repository = GetIt.I.get<Repository>();

  late StateMachineController stateControllerFace;

  late RiveAnimationController animcontrollerSand0;

  SMITrigger? _sleep;
  SMITrigger? _wake;

  bool isRunning = false;

  Timer? rotationTimer;

  StreamSubscription<dynamic>? _streamSubscription;

  init() {
    // runTimerRotation();

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

    _streamSubscription?.cancel();
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

  testSend() async {
    print('test');
    // final counterStream = await test();
    // Stream<String> counterStream = test();
    // Stream.periodic(Duration(seconds: 1), (count) => (count + 1).toString());

    _streamSubscription = (await test()).asBroadcastStream().listen((event) {
      final newState = state.copyWith(text: (state.text ?? '') + event.toString());
      emit(newState);
    });
  }

  clearStream() {
    _streamSubscription?.cancel();
    final newState = state.copyWith(text: '...');
    emit(newState);
  }

  Future<Stream<String>> test() async {
    return await repository.genResponse();
    // for (int i = 1; i <= 5; i++) {
    //   yield i.toString(); // Emit the next value in the stream
    //   await Future.delayed(Duration(seconds: 1)); // Simulate some delay
    // }
  }
}
