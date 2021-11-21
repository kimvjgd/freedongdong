import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_dongdong/home_page.dart';
import 'package:free_dongdong/models/firebase_auth_state.dart';
import 'package:free_dongdong/models/user_model_state.dart';
import 'package:free_dongdong/repo/user_network_repository.dart';
import 'package:free_dongdong/screens/auth_screen.dart';
import 'package:free_dongdong/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _currentWidget = HomePage();
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    _firebaseAuthState.watchAuthChange();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
          value: _firebaseAuthState,
        ),
        ChangeNotifierProvider(create: (_) => UserModelState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<FirebaseAuthState>(builder: (BuildContext context,
            FirebaseAuthState? firebaseAuthState, Widget? child) {
          switch (firebaseAuthState!.firebaseAuthStatus) {
            case FirebaseAuthStatus.signout:
              _clearUserModel(context);
              _currentWidget = AuthScreen();
              break;
            case FirebaseAuthStatus.signin:
              _initUserModel(firebaseAuthState, context);
              _currentWidget = HomePage();
              break;
            default:
              _currentWidget = MyProgressIndicator(containerSize: 20);
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _currentWidget,
          );
        }),
      ),
    );
  }

  void _initUserModel(FirebaseAuthState firebaseAuthState, BuildContext context) {

    UserModelState userModelState = Provider.of(context, listen: false);      // 여기서 provider로 userModelState를 계속 불러와준다.

    userModelState.currentStreamSub = userNetworkRepository
        .getUserModelStream(firebaseAuthState.firebaseUser!.uid)              // getUserModelStream은 userModel을 stream으로 계속 불러온다.
        .listen((userModel) {
      userModelState.userModel = userModel;                                   // userModelState의 userModel을 getUserModelStream으로 계속 불러오는 userModel로 계속 바꿔준다.
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
