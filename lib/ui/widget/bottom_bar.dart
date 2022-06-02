import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';


class NavigationBarWidget extends StatefulWidget {

  @override
  NavigationBarWidgetState createState() =>NavigationBarWidgetState();
}

class NavigationBarWidgetState extends State<NavigationBarWidget> {
     int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
  selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
        elevation: 0, // to get rid of the shadow
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Color.fromARGB(30, 255, 255, 255), // transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppTheme.subTitle,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Images.home,color: AppTheme.bottomBar,width: 30,),
            label: 'Home',
          ),
             BottomNavigationBarItem(
            icon: SvgPicture.asset(Images.search,color: AppTheme.bottomBar,width: 30,),
            label: 'Search',
          ),
             BottomNavigationBarItem(
            icon: SvgPicture.asset(Images.lib,color: AppTheme.bottomBar,width: 30,),
            label: 'Library',
          ),
            BottomNavigationBarItem(
            icon: SvgPicture.asset(Images.sdcard,color: AppTheme.bottomBar,width: 30,),
            label: 'Local',
          ),
          ]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

