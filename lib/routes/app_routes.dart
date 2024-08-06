import 'package:cabi_app/screens/team/team_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cabi_app/screens/index.dart';

class AppRoutes {
  static String home = "/";
  static String createUpdateTournament = "/create-update-tournament";
  static String tournamentDetail = "/tournament-detail";
  static String tournamentsScreen = "/tournament-screen";

  static String tournamentUserScreen = "/tournament-user-screen";

  static String createUpdateCategory = "/create-update-category";
  static String categoryDetail = "/category-detail";
  static String categoriesScreen = "/categories-screen";

  static String createUpdateTeam = "/create-team";  
  static String teamDetail = "/team-detail"; 
  static String teamScreen = "/team-screen";

  static String createUpdatePlayer = "/create-player";
  static String playerScreen = "/player-screen";
  static String playerDetail = "/player-detail"; 

  static String registerScreen = "/register";
  static String loginScreen = "/login";
}

final routesConfig = GoRouter(
  errorBuilder: (context, state) => const Center(
    child: Text("404 not found page"),
  ),
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.tournamentsScreen,
      builder: (context, state) => const TournamentScreen(),
    ),
    GoRoute(
      path: AppRoutes.tournamentDetail,
      builder: (context, state) => TournamentDetailScreen( tournamentId: '${state.uri.queryParameters["tournament_id"]}'),
    ),
    GoRoute(
      path: AppRoutes.createUpdateTournament,
      builder: (context, state) => CreateTournamentScreen( tournamentId: state.uri.queryParameters["tournament_id"]),
    ),
    GoRoute(
      path: AppRoutes.categoriesScreen,
      builder: (context, state) => const CategoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.categoryDetail,
      builder: (context, state) => CategoryDetailScreen( categoryId: '${state.uri.queryParameters["category_id"]}'),
    ),
    GoRoute(
      path: AppRoutes.createUpdateCategory,
      builder: (context, state) => CreateCategoryScreen( categoryId: state.uri.queryParameters["category_id"]),
    ),
    GoRoute(
      path: AppRoutes.teamScreen,
      builder: (context, state) => const TeamScreen(),
    ),
    GoRoute(
      path: AppRoutes.teamDetail,
      builder: (context, state) => TeamDetailScreen( teamId: '${state.uri.queryParameters["team_id"]}'),
    ),
    GoRoute(
      path: AppRoutes.createUpdateTeam,
      builder: (context, state) => CreateTeamScreen( teamId: state.uri.queryParameters["team_id"]),
    ),
    GoRoute(
      path: AppRoutes.createUpdatePlayer,
      builder: (context, state) => const CreatePlayerScreen(),
    ),
    GoRoute(
      path: AppRoutes.tournamentUserScreen,
      builder: (context, state) => const TournamentUserScreen(),
    ),
    GoRoute(
      path: AppRoutes.playerScreen,
      builder: (context, state) => PlayerScreen(
        playerId: '${state.uri.queryParameters["player_id"]}',
      ),
    ),

    GoRoute(
      path: AppRoutes.registerScreen,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
//     GoRoute(
//       path: AppRoutes.createUpdate,
//       builder: (context, state) => CreateTournamentScreen(tournamentId: state.uri.queryParameters["tournamentId"]),
//     ),
//     GoRoute(
//       path: AppRoutes.tournamentsListView,
//       builder: (context, state) => const TournamentsListScreen(),
//     ),
//     GoRoute(
//       // path: AppRoutes.productDetail + '/:productId',
// // Suggested code may be subject to a license. Learn more: ~LicenseLog:2237042173.
//       path: '${AppRoutes.tournamentDetail}/:tournamentId',
//       builder: (context, state) => TournamentDetailScreen(
//         tournamentId: state.pathParameters['tournamentId'],
//       ),
    
  ],
);