import 'package:cabi_app/widgets/player/card_item_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/providers/player_provider.dart';
import '/routes/app_routes.dart';


class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersProv = ref.watch(getPlayersProvider);

    Future<void> onRefresher() async {
      ref.invalidate(getPlayersProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jugadores'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.createPlayer);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresher,
        child: ListView(
          children: [
            Column(
              children: [
                playersProv.when(
                    data: (players) => Column(
                          children: players
                              .map((p) => CardItemPlayer(player: p))
                              .toList(),
                        ),
                    error: (err, trace) => Column(
                          children: [
                            Text(err.toString()),
                            Text(trace.toString())
                          ],
                        ),
                    loading: () => const CircularProgressIndicator())
              ],
            )
          ],
        ),
      ),
    );
  }
}
