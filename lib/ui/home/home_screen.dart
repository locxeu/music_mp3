import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';
import 'package:music_mp3_app/instance/instance.dart';
import 'package:music_mp3_app/ui/home/widget/artist.dart';
import 'package:music_mp3_app/ui/home/widget/chart.dart';
import 'package:music_mp3_app/ui/home/widget/relax_playist.dart';
import 'package:music_mp3_app/ui/widget/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController hours =TextEditingController();
  final TextEditingController minutes =TextEditingController();
     int endTime = DateTime.now().millisecondsSinceEpoch ;
          CountdownTimerController controller= CountdownTimerController(endTime: DateTime.now().millisecondsSinceEpoch);

num duration=0;
@override
  void initState() {
    // TODO: implement initState
    log('endTime $endTime');

    super.initState();
  }
  void onEnd(){
   Instances.player.pause();
  }
  void getTimeToStop(int hour,int minute){
      duration= (hour*60*60+minute*60)*1000;
      endTime=endTime+duration as int;
      log('duration $duration');
      log('endTime $endTime');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: SizedBox(
                                height: 200,
                                child: Column(
                                  children: [
                                    const Text('enter'),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          width: 100,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child:  TextField(
                                            controller: hours,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 30,
                                                        horizontal: 15),
                                                border: InputBorder.none,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 197, 63, 209),
                                                      width: 1.0),
                                                ),
                                                fillColor: Colors.red),
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(':'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Container(
                                          width: 100,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child:  TextField(
                                            controller: minutes,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 30,
                                                        horizontal: 15),
                                                border: InputBorder.none,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 197, 63, 209),
                                                      width: 1.0),
                                                ),
                                                fillColor: Colors.red),
                                          ),
                                        )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Hours',
                                          style: TextStyle(
                                              color: AppTheme.subTitle,
                                              fontSize: 17),
                                        ),
                                        const SizedBox(
                                          width: 80,
                                        ),
                                        Text('Minutes',
                                            style: TextStyle(
                                                color: AppTheme.subTitle,
                                                fontSize: 20))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.grey.shade100, // background
                                             onPrimary: const Color.fromARGB(
                                                          255, 197, 63, 209),   // foreground           
                                            ),
                                            onPressed: () {},
                                            child: const Text('Cancel')),
                                            ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.grey.shade100, // background
                                             onPrimary: const Color.fromARGB(
                                                          255, 197, 63, 209),    // foreground           
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                  getTimeToStop(int.parse(hours.text),int.parse(minutes.text));
                                                   controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
                                              });
                                              log('hours ${hours.text}');
                                               log('hours ${minutes.text}');
                                         // controller.start();
                                            },
                                            child: const Text('Ok')),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.timer,
                    color: Colors.white,
                  ),
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
          //   CountdownTimer(
          //     controller: controller,
          //     onEnd: onEnd,
          //     endTime: endTime,
          // ),
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Thư giãn',
                      style: AppTheme.headLine3,
                    )),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                              title: 'Sorry',
                              descriptions:
                                  'This feature is not availabe yet!!!'
                                      .toString(),
                              text: 'OK',
                              imageFile: Images.error,
                            );
                          });
                    },
                    child: const RelaxPlayist()),
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
              ],
            ),
          ))
        ],
      ),
    );
  }
}
