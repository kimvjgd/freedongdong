import 'package:flutter/material.dart';

class DongScreen extends StatefulWidget {
  const DongScreen({Key? key}) : super(key: key);

  @override
  _DongScreenState createState() => _DongScreenState();
}

class _DongScreenState extends State<DongScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          'assets/images/banner.png',
          fit: BoxFit.fitHeight,
        ),
        Text('동동이는 누구인가?', style: TextStyle(fontSize: 50, fontFamily: 'DonghyunKo'),),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '동동이 저를 소개합니다.\n'
                '저는 1996년생 입니다.\n'
                '연세대학교 공대 다니고 있어요~\n'
                '학교 주변에서 살고있어요.\n'
                '평화로운 분위기를 중시하며\n'
                '\n'
                '\n'
                '\n'
                '\n'
            ,style: TextStyle(fontSize: 25, fontFamily: 'DonghyunKo'),),
        ),
      ],
    );
  }
}
