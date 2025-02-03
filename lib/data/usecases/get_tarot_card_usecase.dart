import 'package:hourglass/data/repository.dart';
import 'package:hourglass/models/tarot_card.dart';

class GetTarotCardUsecase {
  final Repository repository;

  GetTarotCardUsecase({required this.repository});

  Future<List<TarotCard>> call() async {
    return await repository.getTarotCard();
  }
}
