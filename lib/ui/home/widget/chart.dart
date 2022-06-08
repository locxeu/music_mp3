import 'package:flutter/material.dart';
class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/charts/global.jpg',
                  width: 150,
                  height: 180,
                ),
                const Text('global')
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/charts/vietnam.jpg',
                  width: 150,
                  height: 180,
                ),
                const Text('vietnam')
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/charts/korean.jpg',
                  width: 150,
                  height: 180,
                ),
                const Text('korean')
              ],
            ),
          )
        ],
      ),
    );
  }
}
