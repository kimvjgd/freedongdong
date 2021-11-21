import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_dongdong/repo/user_network_repository.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _firebaseUser;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {            // firebaseUser은 _firebaseAuth에서 온거고 _firebaseUser은 여기서 만든거
      if (firebaseUser == null && _firebaseUser == null) {      // 완전 처음에 firebaseUser와 _firebaseUser 모두 없으면 그냥 return으로 넘어간다.
        return;
      } else if (firebaseUser != _firebaseUser) {           // firebaseUser와 _firebaseUser이 같지 않으면
        _firebaseUser = firebaseUser;                       // 여기 FirebaseAuthState 의 _firebaseUser을 auth에서 받아온 firebaseUser로 바꿔준다.
        changeFirebaseAuthStatus();                         //firebaseAuthStatus는 그냥 null로 본건가?
      }
    });
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {                      // firebaseAuthStatus != null이면 ( 그러니깐 새삥인거지)
      _firebaseAuthStatus = firebaseAuthStatus;             // firebaseAuthStatus에 뭔가 들어가 있으면 _firebaseAuthStatus를 바꿔준다.
    } else {                                               // firebaseAuthStatus == null이면
      if (_firebaseUser != null) {                                    // firebaseUser != null이면
        _firebaseAuthStatus = FirebaseAuthStatus.signin;              // _firebaseAuthStatus = signin으로 바꿔준다.
      } else {                                                        // firebaseUser == null
        _firebaseAuthStatus = FirebaseAuthStatus.signout;             // _firebaseAuthStatus = signout으로 바꿔준다.
      }
    }
    notifyListeners();
  }

  void registerUser(BuildContext context,
      {required String email, required String password}) async {
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          _message = "패스워드 잘 넣어줘!!";
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = "이멜 주소가 좀 이상해!";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _message = "해당 이멜은 다른 사람이 쓰고있네??";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    User? firebaseUser = authResult.user;
    if(firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text('Please try again later.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await userNetworkRepository.attemptCreateUser(userKey: firebaseUser.uid, email: firebaseUser.email!);
    }
  }

  void login(BuildContext context,
      {required String email, required String password}) {
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          _message = "멜주고 고쳐!";
          break;
        case 'ERROR_WRONG_PASSWORD':
          _message = "비번 이상";
          break;
        case 'ERROR_USER_NOT_FOUND':
          _message = "유저 없는데?";
          break;
        case 'ERROR_USER_DISABLED':
          _message = "해당 유저 금지되";
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          _message = "너무 많이 시도하는데?? 나중에 다시 해봐~~~";
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          _message = "해당 동작은 여기서는 금지야!!";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }


  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
  User? get firebaseUser => _firebaseUser;
}

enum FirebaseAuthStatus { signout, progress, signin }
