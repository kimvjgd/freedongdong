import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_dongdong/constants/firestore_keys.dart';

class UserModel {
  final String userKey;
  final String email;
  final String universityName;
  final List<dynamic> alarmList;
  final DocumentReference reference;
  // this.username, this.universityName, this.alarmList, this.userKey,
  UserModel.fromMap(Map<String, dynamic>? map,this.userKey, {required this.reference})          // 하나씩 5개 있는 것을 3/1/1 로 묶었다
  :
  email = map![KEY_USEREMAIL],
  universityName = map[KEY_UNIVERSITYNAME],
  alarmList = map[KEY_USERALARMLIST];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)                                             // 3/1/1 을 1개로 묶었다.
  :this.fromMap(snapshot.data(), snapshot.id, reference: snapshot.reference);


  static Map<String, dynamic> getMapForCreateUser(String email) {        // return type은 Map<String, dynamic>
    Map<String, dynamic> map = Map();
    map[KEY_USEREMAIL] = email;
    map[KEY_UNIVERSITYNAME] = '';
    map[KEY_USERALARMLIST] = [];
    return map;
  }
}