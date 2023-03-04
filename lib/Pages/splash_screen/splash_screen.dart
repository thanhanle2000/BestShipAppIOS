import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            color: Colors.white,
            child: Column(children: [
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Expanded(
                        child: SizedBox(
                            height: 250.0,
                            child: Center(
                                child: Column(children: [
                              Image.asset('assets/images/Bestship_logo.png',
                                  height: 150, width: 190),
                              const Text('Bestship ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colours.textDefault)),
                              const Text(
                                  'Dịch vụ giao hàng tốt nhất dành cho bạn',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Colours.textDefault))
                            ]))))
                  ]))
            ])));
  }
}
