import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';


class NavigationBarWidget extends StatefulWidget {
  final Function(int) onTap;
  final int index;
  const NavigationBarWidget({Key? key,required this.onTap,required this.index}) : super(key: key); 

  @override
  NavigationBarWidgetState createState() =>NavigationBarWidgetState();
}

class NavigationBarWidgetState extends State<NavigationBarWidget> {
ListQueue<int> _navigationQueue = ListQueue();
  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
        elevation: 0, // to get rid of the shadow
        currentIndex:widget.index,
        selectedItemColor: Colors.white,
        onTap: widget.onTap,
        backgroundColor: const Color.fromARGB(30, 255, 255, 255), // transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppTheme.subTitle,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Images.home,color:widget.index==0?AppTheme.bottomBar:AppTheme.subTitle,width: 30,),
            label: 'Home',
          ),
             BottomNavigationBarItem(
            icon: SvgPicture.asset(Images.search,color:widget.index==1?AppTheme.bottomBar:AppTheme.subTitle,width: 30,),
            label: 'Search',
          ),
             BottomNavigationBarItem(
            icon: SvgPicture.asset(Images.lib,color:widget.index==2?AppTheme.bottomBar:AppTheme.subTitle,width: 30,),
            label: 'Library',
          ),
            BottomNavigationBarItem(
            icon: SvgPicture.asset(Images.sdcard,color:widget.index==3?AppTheme.bottomBar:AppTheme.subTitle,width: 30,),
            label: 'Local',
          ),
          ]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

