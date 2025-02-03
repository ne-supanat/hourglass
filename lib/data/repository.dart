import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hourglass/models/tarot_card.dart';

class Repository {
  Repository();

  Repository._();

  // The single instance of the class
  static final Repository _instance = Repository._();

  // Public getter to access the instance
  static Repository get instance => _instance;

  Future<List<TarotCard>> getTarotCard() async {
    final String response = await rootBundle.loadString('assets/data/tarot_cards.json');
    final data = await json.decode(response);
    return (data as List).map((e) => TarotCard.fromJson(e)).toList();
  }
}
