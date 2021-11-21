import 'package:free_dongdong/models/youtube_model.dart';

class YoutubeList {
  List<YoutubeModel> _yList = [
    YoutubeModel(
      init: 'https://www.youtube.com/watch?v=lP_Bh6WFwPI&t=37s',
      mid: 'https://www.youtube.com/watch?v=uqxtWo_ccGg',
      fin: 'https://www.youtube.com/watch?v=05mmspbCwTo',
      summary: 'https://www.youtube.com/watch?v=3BVRh4VK2zE'
    ),
    YoutubeModel(
        init: '2222',
        mid: '2222',
        fin: '2222',
        summary: '2222'
    ),
    YoutubeModel(
        init: '3333',
        mid: '3333',
        fin: '3333',
        summary: '3333'
    ),
    YoutubeModel(
        init: '4444',
        mid: '4444',
        fin: '4444',
        summary: '4444'
    ),
  ];

  List get yList => _yList;
}