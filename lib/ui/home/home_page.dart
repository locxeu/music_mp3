import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:music_mp3_app/provider/searchSongState.dart';
import 'package:music_mp3_app/ui/home/home_screen.dart';
import 'package:music_mp3_app/ui/library/lib_page.dart';
import 'package:music_mp3_app/ui/local/local_page.dart';
import 'package:music_mp3_app/ui/search/search_page.dart';
import 'package:music_mp3_app/ui/widget/bottom_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final ListQueue<int> _navigationQueue = ListQueue();
  Future<bool> _willPopScope() async {
    print('opo');
    if (_navigationQueue.isEmpty) {
      return true;
    }
    setState(() {
      index = _navigationQueue.last;
      _navigationQueue.removeLast();
    });
    return false;
  }

  void changeIndexBottomBar(value) {
    _navigationQueue.addLast(index);
    setState(() => index = value);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopScope,
      child: Scaffold(
        extendBody: true,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover)),
          child: ChangeNotifierProvider(
            create: ((context) =>  SearchSongState()),
            child: getBody(index)),
        ),
        bottomNavigationBar: InkWell(
            child: NavigationBarWidget(
          onTap: changeIndexBottomBar,
          index: index,
        )),
      ),
    );
  }

  Widget? getBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      // Create this function, it should return your first page as a widget
      case 1:
        return const SearchPage();
      // Create this function, it should return your second page as a widget
      case 2:
        return  LibraryPage(); // Create this function, it should return your third page as a widget
      case 3:
        return const LocalPage(); // Create this function, it should return your fourth page as a widget
    }
    return null;
  }
}
