import 'package:flutter/material.dart';
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
      body: const Column(
        children: [
          Text('Equipos del usuario')
        ],
      ),
    );
  }
}
