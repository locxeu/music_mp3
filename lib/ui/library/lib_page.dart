import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:folder_file_saver/folder_file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String progress = "0";
  bool _isLoading = false;
  final urlVideo =
          'https://rr2---sn-42u-i5oes.googlevideo.com/videoplayback?expire=1654875696&ei=0BGjYru4M8aOvcAPqfq8wAE&ip=1.55.108.212&id=o-AGJObCJZwzzg_4LL5kb0geIeghJyco-p7A5ihyDjsby0&itag=140&source=youtube&requiressl=yes&mh=VK&mm=31,26&mn=sn-42u-i5oes,sn-oguesn6s&ms=au,onr&mv=m&mvi=2&pcm2cms=yes&pl=24&initcwndbps=2071250&spc=4ocVC4ZsSCuwhQHT1HT0Jo3-3OKT9E0&vprv=1&mime=audio/mp4&ns=oYzl9fO8ENTtWdNQwGrCEGwG&gir=yes&clen=5455652&dur=337.060&lmt=1639904228545548&mt=1654853580&fvip=2&keepalive=yes&fexp=24001373,24007246&c=WEB&txp=5532434&n=2cprQbCou-2ov9g-7p&sparams=expire,ei,ip,id,itag,source,requiressl,spc,vprv,mime,ns,gir,clen,dur,lmt&lsparams=mh,mm,mn,ms,mv,mvi,pcm2cms,pl,initcwndbps&lsig=AG3C_xAwRQIhAOVWNsyh4DNGRoFj29uj4DjsectWQwKHF5zwF4kafEbCAiBeFPw0o3_H7baW85Nte7tBERQUNLzS4oEcoeoeW8MdzA==&sig=AOq0QJ8wRAIgOSMHU_h6chHEEjg62zs6mT5Mndo29Q2O0YVcJoA7iLcCICXJA1FouK_X2IOpa_5Y0GLafaqhUkJ0o16Cvw6KdiGn',
      urlImage =
          'https://images.unsplash.com/photo-1576039716094-066beef36943?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80';

  final Dio dio = Dio();

  final myCustomDir = 'My Custom Directory';

  @override
  void initState() {
    super.initState();
  }

  void _saveImage() async {
    try {
      // get status permission
      final status = await Permission.storage.status;

      // check status permission
      if (status.isDenied) {
        // request permission
        await Permission.storage.request();
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // do save
      await _doSaveImage();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveFileCustomDir() async {
    try {
      // get status permission
      final status = await Permission.storage.status;

      // check status permission
      if (status.isDenied) {
        // request permission
        await Permission.storage.request();
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // do save
      await _doSaveFileCustom();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveFolderFileExt() async {
    try {
      // get status permission
      final status = await Permission.storage.status;

      // check status permission
      if (status.isDenied) {
        // request permission
        await Permission.storage.request();
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // do save
      await _doSave();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Don't forget to check
  // device permission
  Future<void> _doSaveFileCustom() async {
    final dir = await getApplicationDocumentsDirectory();
    final pathImage = dir.path +
        ('/your_image_named ${DateTime.now().millisecondsSinceEpoch}.png');
    await dio.download(urlImage, pathImage, onReceiveProgress: (rec, total) {
      setState(() {
        progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
      });
    });

    // if you want to get original of Image
    // don't give a value of width or height
    // cause default is return width = 0, height = 0
    // which will make it to get the original image
    // just write like this
    // remove originFile default = false
    final result = await FolderFileSaver.saveFileIntoCustomDir(
      dirNamed: myCustomDir,
      filePath: pathImage,
      removeOriginFile: true,
    );
    print(result);
  }

  // Don't forget to check
  // device permission
  Future<void> _doSaveImage() async {
    final dir = await getApplicationDocumentsDirectory();
    final pathImage = dir.path +
        ('/your_image_named ${DateTime.now().millisecondsSinceEpoch}.png');
    await dio.download(urlImage, pathImage, onReceiveProgress: (rec, total) {
      setState(() {
        progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
      });
    });
    // if you want to get original of Image
    // don't give a value of width or height
    // cause default is return width = 0, height = 0
    // which will make it to get the original image
    // just write like this
    // remove originFile default = false
    final result = await FolderFileSaver.saveImage(
      pathImage: pathImage,
      removeOriginFile: true,
    );
    print(result);
  }

  // Don't forget to check
  // device permission
  Future<void> _doSave() async {
    final dir = await getApplicationDocumentsDirectory();
    // prepare the file and type extension that you want to download
    // remove originFile after success default = false
    final filePath = dir.path +
        ('/your_file_named ${DateTime.now().millisecondsSinceEpoch}.mp3');
    await dio.download(urlVideo, filePath, onReceiveProgress: (rec, total) {
      setState(() {
        progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
      });
    });
    final result = await FolderFileSaver.saveFileToFolderExt(
      filePath,
      removeOriginFile: true,
    );
    print(result);
  }

  // Don't forget to check
  // device permission
  void saveFile() async {
    final dir = await getApplicationDocumentsDirectory();
    // prepare the file and type extension that you want to download
    final filePath = dir.path +
        ('/your_file_named ${DateTime.now().millisecondsSinceEpoch}.mp3');
    try {
      await dio.download(urlVideo, filePath);
      final result = await FolderFileSaver.saveFileToFolderExt(filePath);
      print(result);
    } catch (e) {
      // debugPrint(e);
      log('loi $e');
    }
  }

  // Don't foreget check your permission
  void copyFileToNewFolder() async {
    setState(() {
      _isLoading = true;
    });
    // get your path from your device your device
    // final fileToCopy = '/storage/emulated/0/DCIM/Camera/20200102_202226.jpg'; // example
    // remove originFile default = false
    const fileToCopy ='/storage/emulated/0/Download/vu.mp3';
    try {
      await FolderFileSaver.saveFileToFolderExt(fileToCopy);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('Folder File Saver Example'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveImage,
                  child: Text(_isLoading
                      ? 'Downloading $progress'
                      : 'Download Image and Resize'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveFileCustomDir,
                  child: Text(_isLoading
                      ? 'Downloading $progress'
                      : 'Download Image And Save to Custom Directory'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveFolderFileExt,
                  child: Text(
                      _isLoading ? 'Downloading $progress' : 'Download File'),
                ),
                ElevatedButton(
                  onPressed: copyFileToNewFolder,
                  child: const Text('Copy File to Folder'),
                ),
                ElevatedButton(
                  onPressed: () async => await FolderFileSaver.openSetting,
                  child: const Text('Open Setting App'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}