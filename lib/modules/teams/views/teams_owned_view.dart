import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/teams/widgets/create_team_bottom_sheet.dart';
import 'package:movil_cabi_app/shared/widgets/drawer_widget.dart';

class TeamsOwnedView extends StatelessWidget {
  const TeamsOwnedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipos del usuario'),
      ),
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.bottomSheet(const CreateTeamBottomSheet());
        },
        label: const Text('Crear Equipo'),
      ),
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('Equipos del usuario')],
        ),
      ),
    );
  }
}
