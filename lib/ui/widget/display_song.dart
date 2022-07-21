import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';

class DisplaySong extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;
  final Function playSong;
  const DisplaySong(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.duration, required this.playSong})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.headLine7,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      duration,
                      style: AppTheme.headLine6,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
            Icon(
              Icons.more_vert,
              color: AppTheme.backgroundColor,
              size: 20,
            )
          ]),
          Divider(
            thickness: 0.5,
            color: Colors.grey.shade500,
            indent: 65,
          ),
        ],
      ),
    );
  }
}
