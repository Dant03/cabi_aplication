import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/teams/providers/teams_provider.dart';

class TeamDetailWidget extends ConsumerWidget {
  final int id;
  const TeamDetailWidget(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.parse(Get.arguments());
    final teamByIdProv = ref.watch(TeamsProvider.getTeamByIdProvider(id));
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: teamByIdProv.when(
        data: (team) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  team.teamLogo!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                team.teamName ?? 'sin-nombre',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Teléfono: ${team.teamPhone}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Email: ${team.teamEmail}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        error: (obj, str) => Center(
          child: Text('${obj.toString()}:::${str.toString()}'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
