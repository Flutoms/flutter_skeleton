
import 'package:flutter/material.dart';
import 'package:midlr/utils/colors.dart';
import 'package:midlr/utils/helpers.dart';
import 'package:midlr/utils/loader_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void afterSplash() async {
    await Future.delayed(
        const Duration(milliseconds: 200), () async => checkToken());
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => afterSplash());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: AnimatedLogo(),
      ),
    );
  }
}
