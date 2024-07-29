import 'package:flutter/material.dart';

class GeneralLogoSpace extends StatelessWidget {
  const GeneralLogoSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/login.gif",
            width: 120,
          ),
        ],
      ),
    );
  }
}
