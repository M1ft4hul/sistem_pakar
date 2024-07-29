import 'package:flutter/material.dart';
import 'package:sistem_pakar/Components/color.dart';
import 'package:sistem_pakar/page/dashboard.dart';

class Pola extends StatelessWidget {
  const Pola({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "POLA HIDUP",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      TColor.primaryColor2.withOpacity(0.3),
                      TColor.primaryColor1.withOpacity(0.3)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Target Hari ini",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        // SizedBox(
                        //   width: 30,
                        //   height: 30,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: TColor.primaryG,
                        //       ),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: MaterialButton(
                        //       onPressed: () {
                        //         Navigator.pushReplacement(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => const Home()));
                        //       },
                        //       padding: EdgeInsets.zero,
                        //       height: 30,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(25)),
                        //       textColor: TColor.primaryColor1,
                        //       minWidth: double.maxFinite,
                        //       elevation: 0,
                        //       color: Colors.transparent,
                        //       child: const Icon(
                        //         Icons.home,
                        //         color: Colors.white,
                        //         size: 15,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: TodayTargetCell(
                            icon: "assets/gelas.png",
                            value: "8L",
                            title: "Asupan Air",
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TodayTargetCell(
                            icon: "assets/sepatu.png",
                            value: "2400",
                            title: "Langkah Kaki",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: media.width * 0.09,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      TColor.primaryColor2.withOpacity(0.3),
                      TColor.primaryColor1.withOpacity(0.3)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TodayTargetCell extends StatelessWidget {
  final String icon;
  final String value;
  final String title;
  const TodayTargetCell(
      {super.key,
      required this.icon,
      required this.value,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                          colors: TColor.primaryG,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      .createShader(
                          Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                },
                child: Text(
                  value,
                  style: TextStyle(
                      color: TColor.white.withOpacity(0.7),
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 12,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
