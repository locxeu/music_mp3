import 'package:flutter/cupertino.dart';
import 'package:music_mp3_app/ui/widget/loading.dart';

class BaseState extends ChangeNotifier{

    void setLoading(BuildContext context){
    LoadingWidget.showLoadingDialog(context);
    notifyListeners();
  }

  void setDoneLoading(BuildContext context){
    LoadingWidget.hideLoadingDialog(context);
    notifyListeners();
  }

}