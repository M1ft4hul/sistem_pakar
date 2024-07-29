import 'package:flutter/material.dart';
import 'package:sistem_pakar/widgets/header_nama.dart';
import 'package:sistem_pakar/widgets/menu.dart';
import 'package:sistem_pakar/widgets/riwayat_diagnosa.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            Text(
              "Welcome",
              style: TextStyle(
                color: Colors.purple[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "How are you feeling today?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const SizedBox(
            height: 3,
          ),
          // header nama
          const Header(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Health Need",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 15,
          ),
          // menu
          const Menu(),

          const SizedBox(
            height: 30,
          ),
          Text(
            "Riwayat Diagnosa",
            style: TextStyle(
              color: Colors.purple[900],
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          const SizedBox(
            height: 300,
            child: Riwayat(),
          ), // riwayat diagnosa
        ],
      ),
    );
  }
}
