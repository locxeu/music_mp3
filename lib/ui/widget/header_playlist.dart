import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';

class HeaderPlaylist extends StatelessWidget {
  final String title;
  const HeaderPlaylist({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild child');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              color: AppTheme.backgroundColor,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: AppTheme.headLine3,
          ),
          const Spacer(flex: 2)
        ],
      ),
    );
  }
}
