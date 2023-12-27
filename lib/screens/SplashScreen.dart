import 'package:calculator/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode((SystemUiMode.immersive));

    Future.delayed(Duration(seconds: 2), () {
     Navigator.pushNamed(context, '/home');
    });
  }



  @override
void dispose() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 21, 0, 40),
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 800,
            height: 800,
          ),
        ),
      ),
    );
  }
}
