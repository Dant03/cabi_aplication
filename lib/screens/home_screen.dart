import 'package:cabi_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campeonato de Baloncesto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              color: Colors.amberAccent,
              iconSize: 50,
              visualDensity: VisualDensity.standard,
              onPressed: () {
                context.push(AppRoutes.tournamentsScreen);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TournamentScreen()),
                //   // MaterialPageRoute(builder: (context) => CreateTournamentScreen()),
                // );
              }, icon: Icon(Icons.emoji_events),
              
              // child: const Text('Torneos'),
            ),Text('Campeonatos'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoryScreen()),
                );
              },
              child: const Text('Categorias'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.loginScreen);
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.teamScreen);
              },
              child: const Text('Equipos'),
            ),
          ],
        ),
      ),
    );
  }
}
