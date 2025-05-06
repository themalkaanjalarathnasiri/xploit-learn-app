import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/pages/first_onboarding_screen.dart';
import 'package:vulnerability_learn_app/pages/shared_onboarding_screen.dart';
import 'package:vulnerability_learn_app/pages/user_data_page.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import 'package:vulnerability_learn_app/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  bool lastOnboardingPage = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          backgroundColor: kBlack,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView(
                      controller: _controller,
                      onPageChanged: (value) {
                        setState(() {
                          lastOnboardingPage = value == 2;
                        });
                      },
                      children: [
                        FirstOnboardingScreen(),
                        SharedOnboardingScreen(
                          title: "Learn with AI",
                          description:
                              "Our AI assistant helps you understand exploits, techniques, and security concepts step by step",
                          imageUrl:
                              "assets/images/Artificial intelligence-bro.png",
                        ),
                        SharedOnboardingScreen(
                          title: "Explore Exploits",
                          description:
                              "Learn about real-world exploits like SQL Injection, Buffer Overflow, and Privilege Escalation—all in a structured way.",
                          imageUrl: "assets/images/Cyber attack-bro.png",
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: !lastOnboardingPage
                            ? GestureDetector(
                                onTap: () {
                                  _controller.animateToPage(
                                    _controller.page!.toInt() + 1,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: CustomButton(
                                  buttonName: !lastOnboardingPage
                                      ? "Next"
                                      : "Get Started",
                                  buttonColor: kGreen,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserDataScreen(),
                                    ),
                                  );
                                },
                                child: CustomButton(
                                  buttonName: !lastOnboardingPage
                                      ? "Next"
                                      : "Get Started",
                                  buttonColor: kGreen,
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
