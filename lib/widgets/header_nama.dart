import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String email = '';
  String namalengkap = '';

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = (prefs.getString('email') ?? '');
      namalengkap = (prefs.getString('nama_lengkap') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 165,
      padding: const EdgeInsets.symmetric(
        vertical: 22,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/boy.png',
              width: 65,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  namalengkap,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: StreamBuilder(
                  stream: Stream.periodic(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    String currentTime =
                        DateFormat('HH:mm:ss a').format(DateTime.now());
                    String currentDay =
                        DateFormat('EEEE').format(DateTime.now());

                    return Row(
                      children: [
                        const Icon(
                          Ionicons.calendar_outline,
                          size: 18,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14.0, left: 6),
                          child: Text(
                            currentDay,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Ionicons.time_outline,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          currentTime,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
