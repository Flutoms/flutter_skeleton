import 'package:dado_vendor/utils/colors.dart';
import 'package:dado_vendor/utils/global_assets.dart';
import 'package:dado_vendor/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void afterSplash() async {
    await Future.delayed(
        const Duration(milliseconds: 200), () async => checkStatus());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterSplash());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SvgPicture.asset(appLogo),
      ),
    );
  }
}
