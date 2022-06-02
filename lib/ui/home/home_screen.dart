import 'package:flutter/material.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/ui/home/widget/artist.dart';
import 'package:music_mp3_app/ui/home/widget/chart.dart';
import 'package:music_mp3_app/ui/home/widget/relax_playist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'Mới phát gần ...',
                style: AppTheme.headLine1,
              )),
              const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.timer,
                  color: Colors.white,
                ),
              ),
              const Icon(
                Icons.settings,
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bảng xếp hạng',
                      style: AppTheme.headLine3,
                    )),
                const SizedBox(
                  height: 24,
                ),
                const Charts(),
                const SizedBox(
                  height: 24,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nghệ sỹ yêu thích',
                      style: AppTheme.headLine3,
                    )),
                const SizedBox(
                  height: 24,
                ),
                const FavouriteArtist(),
                const SizedBox(
                  height: 24,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Thư giãn',
                      style: AppTheme.headLine3,
                    )),
                    const SizedBox(
                  height: 24,
                ),
              const  RelaxPlayist()

              ],
            ),
          ))
        ],
      ),
    );
  }
}