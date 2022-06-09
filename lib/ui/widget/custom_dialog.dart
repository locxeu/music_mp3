

import 'package:flutter/material.dart';
import 'package:music_mp3_app/config/theme/app_theme.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final String imageFile;
  const CustomDialogBox({ Key? key, required this.title, required this.descriptions, required this.text, required this.imageFile}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: AppTheme.padding,top:AppTheme.avatarRadius
              + AppTheme.padding, right: AppTheme.padding,bottom: AppTheme.padding
          ),
          margin: const EdgeInsets.only(top:AppTheme.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.padding),
            boxShadow: const [
              BoxShadow(color: Colors.black,offset: Offset(0,10),
              blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              const SizedBox(height: 15,),
              Text(widget.descriptions,style: const TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              const SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(widget.text,style: const TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: AppTheme.padding,
            right: AppTheme.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius:AppTheme.avatarRadius,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(AppTheme.avatarRadius)),
                  child: Image.asset(widget.imageFile,width: 50,)
              ),
            ),
        ),
      ],
    );
  }
}