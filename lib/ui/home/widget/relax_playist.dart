import 'package:flutter/material.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';

class RelaxPlayist extends StatefulWidget {
  const RelaxPlayist({Key? key}) : super(key: key);

  @override
  State<RelaxPlayist> createState() => _RelaxPlayistState();
}

class _RelaxPlayistState extends State<RelaxPlayist> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: () {
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Image.asset(
                    Images.coffe,
                    width: 150,
                    height: 180,
                  ),
                  Text('Coffe',style: AppTheme.headLine4,)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Image.asset(
                    Images.piano,
                    width: 150,
                    height: 180,
                  ),
                 Text('Piano',style: AppTheme.headLine4,)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Image.asset(
                    Images.meditation,
                    width: 150,
                    height: 180,
                  ),
                 Text('Meditation',style: AppTheme.headLine4,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
