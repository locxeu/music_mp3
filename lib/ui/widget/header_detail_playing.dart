import 'package:flutter/material.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';

class HeaderPlayingSong extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback setTimer;
  const HeaderPlayingSong({Key? key, required this.onTap, required this.setTimer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: onTap, icon:  Icon(Icons.arrow_back_ios,color: AppTheme.backgroundColor,)),
        Text(
          'Now Playing',
          style: AppTheme.headLine1,
        ),
        IconButton(
          onPressed:setTimer,
          icon:  Icon(Icons.alarm,color: AppTheme.backgroundColor),
        )
      ],
    );
  }
}
