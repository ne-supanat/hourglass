import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hourglass/models/tarot_card.dart';
import 'package:url_launcher/url_launcher.dart';

class TarotCardWidget extends StatefulWidget {
  const TarotCardWidget({
    super.key,
    required this.detail,
    this.width = 75,
    this.fontSize = 16,
    this.reversed = false,
  });

  final TarotCard detail;
  final double width;
  final double fontSize;
  final bool reversed;

  @override
  State<TarotCardWidget> createState() => _TarotCardWidgetState();
}

class _TarotCardWidgetState extends State<TarotCardWidget> {
  final borderRadius = 4.0;

  bool revealed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.width * 1.3,
      child: InkWell(
        onTap: () async {
          if (revealed) {
            await launchUrl(Uri.parse(widget.detail.url));
          } else {
            setState(() {
              revealed = true;
            });
          }
        },
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple.shade200),
            color: revealed ? Colors.white70 : Colors.deepPurple,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: revealed ? frontWidget() : backWidget(),
        ),
      ),
    );
  }

  frontWidget() {
    return Transform.rotate(
      angle: widget.reversed ? pi * 1 : 0,
      child: Text(
        widget.detail.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  backWidget() {
    return Container(
      color: Colors.deepPurple,
      child: const Icon(
        Icons.remove_red_eye_outlined,
        color: Colors.white,
      ),
    );
  }
}
