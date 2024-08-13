import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:movil_cabi_app/modules/auth/views/login_view.dart';
import 'package:movil_cabi_app/modules/auth/views/register_view.dart';
import 'package:movil_cabi_app/modules/auth/views/welcome_view.dart';
import 'package:movil_cabi_app/modules/games/views/game_view.dart';
import 'package:movil_cabi_app/modules/players/views/player_view.dart';
import 'package:movil_cabi_app/modules/teams/views/team_view.dart';
import 'package:movil_cabi_app/modules/tournaments/views/tournament_by_id_view.dart';
import 'package:movil_cabi_app/modules/tournaments/views/tournament_view.dart';
import 'package:movil_cabi_app/modules/users/views/user_view.dart';

class AppRoutes {
  static String welcome = '/';
  static String login = '/login';
  static String register = '/register';
  static String game = '/game';
  static String player = '/player';
  static String team = '/team';
  static String tournament = '/tournament';
  static String tournamentById = '/tournamentById';
  static String user = '/user';
}

final List<GetPage> listPageConfig = [
  GetPage(name: AppRoutes.welcome, page: () => const WelcomeView()),
  GetPage(name: AppRoutes.login, page: () => const LoginView()),
  GetPage(name: AppRoutes.register, page: () => const RegisterView()),
  GetPage(name: AppRoutes.game, page: () => const GameView()),
  GetPage(name: AppRoutes.player, page: () => const PlayerView()),
  GetPage(name: AppRoutes.team, page: () => const TeamView()),
  GetPage(name: AppRoutes.tournament, page: () => const TournamentView()),
  GetPage(name: AppRoutes.tournamentById, page: () => const TournamentByIdView()),
  GetPage(name: AppRoutes.user, page: () => const UserView()),
];
