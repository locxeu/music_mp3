import 'package:flutter/material.dart';

class LoadingWidget{


  static void showLoadingDialog(BuildContext context){
    FocusScope.of(context).unfocus();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.transparent
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text("Loading...", style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          );
        }
    );
  }

  static void hideLoadingDialog(BuildContext context)async{
    Navigator.pop(context);
  }

}