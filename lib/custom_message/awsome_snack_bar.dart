import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_mp3_app/config/theme/image_path.dart';
import 'package:music_mp3_app/custom_message/content_type.dart';

class AwesomeSnackbarContent extends StatelessWidget {
  /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
  /// set backgroundColor: Colors.transparent
  /// set behavior: SnackBarBehavior.floating
  /// set elevation: 0.0

  /// title is the header String that will show on top
  final String title;

  /// message String is the body message which shows only 2 lines at max
  final String message;

  /// `optional` color of the SnackBar body
  final Color? color;

  /// contentType will reflect the overall theme of SnackBar: failure, success, help, warning
  final ContentType contentType;

  const AwesomeSnackbarContent({
    Key? key,
    this.color,
    required this.title,
    required this.message,
    required this.contentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// For managing responsiveness
    Size size = MediaQuery.of(context).size;

    /// For reflecting different color shades in the SnackBar
    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// SnackBar Body
        Center(
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.025,
            ),
            height: size.height * 0.125,
            decoration: BoxDecoration(
              color: color ?? contentType.color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 0.122,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// `title` parameter
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              Images.failure,
                              height: size.height * 0.022,
                              // package: 'awesome_snackbar_content',
                            ),
                          )
                        ],
                      ),
                      const Spacer(),

                      /// `message` body text parameter
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: size.height * 0.016,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// other SVGs in body
        Positioned(
          bottom: size.height * 0.44,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: SvgPicture.asset(
              Images.bubbles,
              height: size.height * 0.06,
              width: size.width * 0.05,
              color: hslDark.toColor(),
              // package: 'awesome_snackbar_content',
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.40,
          left: size.width * 0.035,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                Images.back,
                height: size.height * 0.06,
                color: hslDark.toColor(),
                // package: 'awesome_snackbar_content',
              ),
              Positioned(
                top: size.height * 0.015,
                child: SvgPicture.asset(
                  assetSVG(contentType),
                  height: size.height * 0.022,
                  // package: 'awesome_snackbar_content',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(ContentType contentType) {
    if (contentType == ContentType.failure) {
      /// failure will show `CROSS`
      return Images.failure;
    } else if (contentType == ContentType.success) {
      /// success will show `CHECK`
      return Images.success;
    } else if (contentType == ContentType.warning) {
      /// warning will show `EXCLAMATION`
      return Images.warning;
    } else if (contentType == ContentType.help) {
      /// help will show `QUESTION MARK`
      return Images.help;
    } else {
      return Images.failure;
    }
  }
}
