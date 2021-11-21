import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _url = 'https://www.youtube.com/channel/UC8S-Uj9L91WY_DpbTZnaKsA';

  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          'assets/images/banner.png',
          fit: BoxFit.fitHeight,
        ),
        Text('동동튜브 어플이란?', style: TextStyle(fontSize: 50, fontFamily: 'DonghyunKo'),),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
              '한량 동동이가 살았다고 한다.\n'
              '그는 하고싶은 것들이 너무 많았다고 한다.\n'
              '하지만 그는 실행에 옮기지 않았고\n'
              '나태함의 근원을 찾아보러 떠났는데...\n\n'
            '아래의 사진을 클릭하면 유투브 채널로 이동됩니다.'
          ,style: TextStyle(fontSize: 25, fontFamily: 'DonghyunKo'),),
        ),
        InkWell(
          child: Image.asset(
            'assets/images/character.png',
            fit: BoxFit.fitHeight,
          ),
          onTap: () {
            _launchURL();
          },
        ),
      ],
    );
  }
}
