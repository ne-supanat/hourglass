import 'package:go_router/go_router.dart';
import 'package:hourglass/features/tarot/tarot_view.dart';
import 'package:hourglass/features/main/main_view.dart';

class GoRouteConfig {
  static const pageMain = '/';
  static const pageTarot = '/tarot';

  static GoRouter routerConfig() {
    return GoRouter(
      routes: [
        GoRoute(path: pageMain, builder: (context, state) => const MainView()),
        GoRoute(path: pageTarot, builder: (context, state) => const TarotView()),
      ],
    );
  }
}
