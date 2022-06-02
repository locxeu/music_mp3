import 'package:flutter/material.dart';
import 'package:music_mp3_app/custom_message/awsome_snack_bar.dart';
import 'package:music_mp3_app/custom_message/content_type.dart';

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
          InkWell(
            onTap: () {
              var snackBar = showDialog(
                  context: context,
                  builder: (context) {
                    return AwesomeSnackbarContent(
                      title: 'On Sorry!',
                      message: 'This feature is not available yet!',
                      contentType: ContentType.failure,
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/charts/global.jpg',
                    width: 150,
                    height: 180,
                  ),
                  Text('global')
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              var snackBar = showDialog(
                  context: context,
                  builder: (context) {
                    return AwesomeSnackbarContent(
                      title: 'On Sorry!',
                      message: 'This feature is not available yet!',
                      contentType: ContentType.failure,
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/charts/vietnam.jpg',
                    width: 150,
                    height: 180,
                  ),
                  Text('vietnam')
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              var snackBar = showDialog(
                  context: context,
                  builder: (context) {
                    return AwesomeSnackbarContent(
                      title: 'On Sorry!',
                      message: 'This feature is not available yet!',
                      contentType: ContentType.failure,
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/charts/korean.jpg',
                    width: 150,
                    height: 180,
                  ),
                  Text('korean')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
