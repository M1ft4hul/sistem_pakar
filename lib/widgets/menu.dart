import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_pakar/page/diagnosa.dart';
import 'package:sistem_pakar/page/info_apk.dart';
import 'package:sistem_pakar/page/login.dart';
import 'package:sistem_pakar/page/pola_hidup.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(
        icon: "assets/diagnosa.png",
        name: "Diagnosa",
        page: const Diagnosa(),
      ),
      CustomIcon(
        icon: "assets/gaya.png",
        name: "Pola Hidup",
        page: const Pola(),
      ),
      CustomIcon(
        icon: "assets/info.png",
        name: "Tentang apk",
        page: const Info(),
      ),
      CustomIcon(
        icon: "assets/logout.png",
        name: "Keluar",
        page: Login(),
      ),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        customIcons.length,
        (index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: TextButton(
                  onPressed: () {
                    if (index == customIcons.length - 1) {
                      _logout(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => customIcons[index].page,
                        ),
                      );
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => customIcons[index].page,
                    //   ),
                    // );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.4),
                    ),
                    child: Image.asset(
                      customIcons[index].icon,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(customIcons[index].name),
            ],
          );
        },
      ),
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('nama_lengkap');
    await prefs.remove('hp');
    await prefs.remove('alamat');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }
}

class CustomIcon {
  final String icon;
  final String name;
  final Widget page;
  CustomIcon({
    required this.icon,
    required this.name,
    required this.page,
  });
}
