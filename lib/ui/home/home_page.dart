import 'package:flutter/material.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/ui/home/widget/artist.dart';
import 'package:music_mp3_app/ui/home/widget/chart.dart';
import 'package:music_mp3_app/ui/home/widget/relax_playist.dart';
import 'package:music_mp3_app/ui/widget/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover)),
        child: Padding(
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
        ),
      ),
      bottomNavigationBar:  NavigationBarWidget(),
    );
  }
}
