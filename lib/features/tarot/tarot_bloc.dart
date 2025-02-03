import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hourglass/data/repository.dart';
import 'package:hourglass/data/usecases/get_tarot_card_usecase.dart';
import 'package:hourglass/models/tarot_card.dart';

class TarotState {
  final List<TarotCard> tarotCards;

  TarotState({required this.tarotCards});

  factory TarotState.i() {
    return TarotState(
      tarotCards: [],
    );
  }

  copyWith({List<TarotCard>? tarotCards}) {
    return TarotState(
      tarotCards: tarotCards ?? this.tarotCards,
    );
  }
}

class TarotBloc extends Cubit<TarotState> {
  TarotBloc() : super(TarotState.i());

  final GetTarotCardUsecase _getTarotCardUsecase =
      GetTarotCardUsecase(repository: Repository.instance);

  Future init() async {
    final cards = await _getTarotCardUsecase();

    final newState = state.copyWith(tarotCards: cards..shuffle());
    emit(newState);
  }
}
