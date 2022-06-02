import 'package:flutter/material.dart';
import 'package:music_mp3_app/ui/home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/spash_screen.jpg'),
              fit: BoxFit.cover)),
    );
  }
}
