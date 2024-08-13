import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:movil_cabi_app/modules/tournaments/providers/tournament_provider.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

import '../../tournaments/widgets/tournament_detail_widget.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentsProv =
        ref.watch(TournamentProvider.getTournamentsProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.offAllNamed(AppRoutes.login),
        label: const Text('Iniciar sesión'),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/img/bg-welcome.jpg'), // Añade tu imagen de fondo aquí
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Column(
                      children: [
                        Center(
                      child: Column(
                        children: [
                          Text(
                            'Te damos la bienvenida',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'a CABI',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Image(
                      filterQuality: FilterQuality.medium,
                      height: 200,
                      image: AssetImage('assets/img/logo-aabi-nb.png'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Torneos del momento',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    
                      ],
                    ),
                    tournamentsProv.when(
                      data: (ts) => Column(
                          children: ts
                              .map((t) => TournamentDetailWidget(tournament: t))
                              .toList()),
                      error: (obj, stc) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(obj.toString()),
                            Text(stc.toString())
                          ],
                        ),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
