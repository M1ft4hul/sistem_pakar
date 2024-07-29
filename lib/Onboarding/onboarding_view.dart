import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_pakar/Components/color.dart';
import 'package:sistem_pakar/Onboarding/onboarding_items.dart';
import 'package:sistem_pakar/page/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // tombol next dan kembali
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // tombol skip
                  TextButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.items.length - 1),
                    child: const Text("Skip"),
                  ),

                  // indikator (bulet bulet)
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    ),
                    effect: const WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      activeDotColor: primaryColor,
                    ),
                  ),

                  // tombol next
                  TextButton(
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    ),
                    child: const Text("Next"),
                  ),
                ],
              ),
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].images),
                  const SizedBox(height: 15),
                  // pengaturan judul besar
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // buat teks ke tengah (deskripsi)
                  Text(
                    controller.items[index].descriptions,
                    style: const TextStyle(color: Colors.grey, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
      ),
    );
  }

  // get started
  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: primaryColor,
      ),
      width: MediaQuery.of(context).size.width * 9,
      child: TextButton(
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool("onboarding", true);

          if (!mounted) return;
          // cara hubungkan ke halaman login
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
