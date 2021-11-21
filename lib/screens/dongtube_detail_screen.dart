import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DongtubeDetailScreen extends StatefulWidget {


  final String initId;
  final String midId;
  final String finId;
  final String name;

  const DongtubeDetailScreen(
      {Key? key,
      required this.initId,
      required this.midId,
      required this.finId,
      required this.name})
      : super(key: key);

  @override
  _DongtubeDetailScreenState createState() => _DongtubeDetailScreenState();
}

class _DongtubeDetailScreenState extends State<DongtubeDetailScreen> {


  late YoutubePlayerController _controller_init;
  late YoutubePlayerController _controller_mid;
  late YoutubePlayerController _controller_fin;

  @override
  void initState() {
    super.initState();
    _controller_init = YoutubePlayerController(initialVideoId: widget.initId, flags: YoutubePlayerFlags(autoPlay: false));
    _controller_mid = YoutubePlayerController(initialVideoId: widget.midId, flags: YoutubePlayerFlags(autoPlay: false));
    _controller_fin = YoutubePlayerController(initialVideoId: widget.finId, flags: YoutubePlayerFlags(autoPlay: false));
    print('asdfasdfasdf${_controller_mid}');
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Center(
            child: Container(
              width: 40,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/youtube_channel_logo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          '동동이 유투브',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontFamily: 'DonghyunKo'),
        ),
      ),
      body: Container(
        color: Colors.orangeAccent.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(),
              Text(
                widget.name,
                style: TextStyle(fontSize: 40, fontFamily: 'DonghyunKo'),
              ),
              Text('Init!',style: TextStyle(fontSize: 40, fontFamily: 'DonghyunKo')),
              widget.initId != '' ? Container(child: YoutubePlayer(controller: _controller_init,),): Container(child: Text('아직 영상이 올라오지 않았습니다.',style: TextStyle(fontSize: 20, fontFamily: 'DonghyunKo'),),),
              SizedBox(height: 30,),
              Text('Mid!',style: TextStyle(fontSize: 40, fontFamily: 'DonghyunKo')),
              widget.midId != '' ? Container(child: YoutubePlayer(controller: _controller_mid,),): Container(child: Text('아직 영상이 올라오지 않았습니다.',style: TextStyle(fontSize: 20, fontFamily: 'DonghyunKo'),),),
              SizedBox(height: 30,),
              Text('Fin!',style: TextStyle(fontSize: 40, fontFamily: 'DonghyunKo')),
              widget.finId != '' ? Container(child: YoutubePlayer(controller: _controller_fin,),): Container(child: Text('아직 영상이 올라오지 않았습니다.',style: TextStyle(fontSize: 20, fontFamily: 'DonghyunKo')),),
            ],
          ),
        ),
      ),
    );
  }
}
