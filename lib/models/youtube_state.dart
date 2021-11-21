import 'package:flutter/material.dart';
import 'package:free_dongdong/models/youtube_list.dart';

class YoutubeState extends ChangeNotifier {
  YoutubeList youtubeList = YoutubeList();

  List<dynamic> currentYoutubeList = YoutubeList().yList;

  void getCurrentYoutubeList() {
    currentYoutubeList = youtubeList.yList;
  }
}