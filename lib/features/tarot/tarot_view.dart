import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'card.dart';
import 'tarot_bloc.dart';

class TarotView extends StatefulWidget {
  const TarotView({super.key});

  @override
  State<TarotView> createState() => _TarotViewState();
}

class _TarotViewState extends State<TarotView> {
  final _controller = TarotBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _controller,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: Center(
              child: BlocBuilder<TarotBloc, TarotState>(
                builder: (context, state) {
                  return layout();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  layout() {
    final w = MediaQuery.sizeOf(context).width;

    double cardWidth = 0;
    double fontSize = 0;

    if (w <= 375) {
      cardWidth = 40;
      fontSize = 8;
    } else if (w <= 500) {
      cardWidth = 45;
      fontSize = 10;
    } else if (w <= 825) {
      cardWidth = 65;
      fontSize = 12;
    } else if (w <= 1200) {
      cardWidth = 75;
      fontSize = 14;
    } else {
      cardWidth = 90;
      fontSize = 16;
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        runSpacing: 5,
        children: _controller.state.tarotCards
            .map(
              (e) => TarotCardWidget(
                detail: e,
                width: cardWidth,
                fontSize: fontSize,
                reversed: Random().nextBool(),
              ),
            )
            .toList(),
      ),
    );
  }

  // try layout with table 13x6 or 6x13
  layoutTable() {
    if (_controller.state.tarotCards.isNotEmpty) {
      int row = 1;
      int column = 1;

      if (MediaQuery.sizeOf(context).width < MediaQuery.sizeOf(context).height) {
        row = 13;
        column = 6;
      } else {
        row = 6;
        column = 13;
      }

      double cardW = MediaQuery.sizeOf(context).width / column;
      double cardH = MediaQuery.sizeOf(context).height / row;

      if (cardW < cardH) {}

      return Table(
        children: List.generate(
          row,
          (x) => TableRow(
            children: List.generate(column, (y) {
              final tarotCard = _controller.state.tarotCards[x * 6 + y];
              return Container(
                alignment: Alignment.center,
                width: cardW,
                height: cardH,
                child: TarotCardWidget(detail: tarotCard),
              );
            }).toList(),
          ),
        ).toList(),
      );
    } else {
      return const SizedBox();
    }
  }
}
