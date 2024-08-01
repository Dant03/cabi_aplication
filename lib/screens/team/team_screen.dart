import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/providers/team_provider.dart';
import '/routes/app_routes.dart';
import '/widgets/card_item_team.dart';

class TeamScreen extends ConsumerWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsProv = ref.watch(getTeamsProvider);

    Future<void> onRefresher() async {
      ref.invalidate(getTeamsProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.createTeam);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresher,
        child: ListView(
          children: [
            Column(
              children: [
                teamsProv.when(
                    data: (teams) => Column(
                          children: teams
                              .map((t) => CardItemTeam(team: t))
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
