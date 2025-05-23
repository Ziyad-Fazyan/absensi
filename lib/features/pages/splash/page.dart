import 'package:absensi_app/core/core.dart';
import 'package:absensi_app/features/pages/login/page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => context.pushReplacement(const LoginPage()),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(50),
            child: Center(
              child: Image.asset(
                width: 150,
                height: 150,
                'assets/images/idbc_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
