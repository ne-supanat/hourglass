import 'package:get_it/get_it.dart';
import 'package:hourglass/data/repository.dart';

class TestGenUsecase {
  final Repository _repository = GetIt.I.get<Repository>();

  Future call() async {
    return await _repository.genResponse();
  }
}
