// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';

// import '../../consts/animation_keys.dart';
// import '../../gen/assets.gen.dart';

// class Hourglass extends StatefulWidget {
//   const Hourglass({super.key});

//   @override
//   State<Hourglass> createState() => _HourglassState();
// }

// class _HourglassState extends State<Hourglass> {
//   @override
//   Widget build(BuildContext context) {
//     return Transform.rotate(
//                       angle: pi * -0.2 * (state.isRotationIsPositive ? 1 : -1),
//                       child: RiveAnimation.asset(
//                         Assets.animations.anim,
//                         animations: const [AnimationKeyNames.animFluid],
//                         controllers: [_controller.animcontrollerSand0],
//                         onInit: _controller.setupStateMachine,
//                       ),
//                     );
//                   },
//                 ),
//               );
//   }
// }
