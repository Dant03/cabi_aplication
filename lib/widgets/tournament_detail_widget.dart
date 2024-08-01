import 'package:flutter/material.dart';
import '../models/tournament.dart';

class TournamentDetailWidget extends StatelessWidget {
  final Tournament tournament;

  const TournamentDetailWidget({Key? key, required this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(tournament.image.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                tournament.name!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tournament.location.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Courts: ${tournament.numCourts}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Status: ${tournament.status}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tournament.rules.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Phone: ${tournament.phone}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Email: ${tournament.email}'),
            ),
          ],
        ),
      ),
    );
  }
}
