import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pakar/Components/color.dart';
import 'package:sistem_pakar/Components/icon_title_next_row.dart';
import 'package:sistem_pakar/Components/round_button.dart';

class JadwalTidur extends StatefulWidget {
  const JadwalTidur({super.key, required DateTime date});

  @override
  State<JadwalTidur> createState() => _JadwalTidurState();
}

class _JadwalTidurState extends State<JadwalTidur> {
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Alarm",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: TColor.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            IconTitleNextRow(
              icon: "assets/Bed_Add.png",
              title: "Bedtime",
              time: "09:00 PM",
              color: TColor.lightGray,
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            IconTitleNextRow(
              icon: "assets/HoursTime.png",
              title: "Hours of sleep",
              time: "8hours 30minutes",
              color: TColor.lightGray,
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            IconTitleNextRow(
              icon: "assets/Repeat.png",
              title: "Repeat",
              time: "Mon to Fri",
              color: TColor.lightGray,
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/Vibrate.png",
                      width: 18,
                      height: 18,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Vibrate When Alarm Sound",
                      style: TextStyle(color: TColor.gray, fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Transform.scale(
                      scale: 0.7,
                      child: CustomAnimatedToggleSwitch<bool>(
                        current: positive,
                        values: [false, true],
                        dif: 0.0,
                        indicatorSize: const Size.square(30.0),
                        animationDuration: const Duration(milliseconds: 200),
                        animationCurve: Curves.linear,
                        onChanged: (b) => setState(() => positive = b),
                        iconBuilder: (context, local, global) {
                          return const SizedBox();
                        },
                        defaultCursor: SystemMouseCursors.click,
                        onTap: () => setState(() => positive = !positive),
                        iconsTappable: false,
                        wrapperBuilder: (context, global, child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 10.0,
                                right: 10.0,
                                height: 30.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: TColor.secondaryG),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                              child,
                            ],
                          );
                        },
                        foregroundIndicatorBuilder: (context, global) {
                          return SizedBox.fromSize(
                            size: const Size(10, 10),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: TColor.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0.05,
                                    blurRadius: 1.1,
                                    offset: Offset(0.0, 0.8),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            RoundButton(
              title: "Tambah Alarm",
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
