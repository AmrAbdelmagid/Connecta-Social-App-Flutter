import 'package:bloc/bloc.dart';
import 'package:connecta_social_app/components/app_toast.dart';
import 'package:connecta_social_app/cubits/login_cubit/login_cubit.dart';
import 'package:connecta_social_app/cubits/register_cubit/register_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/layouts/social_layout.dart';
import 'package:connecta_social_app/screens/add_post_screen.dart';
import 'package:connecta_social_app/screens/chat_screen.dart';
import 'package:connecta_social_app/screens/edit_profile_screen.dart';
import 'package:connecta_social_app/screens/login_screen.dart';
import 'package:connecta_social_app/screens/profile_screen.dart';
import 'package:connecta_social_app/screens/register_screen.dart';
import 'package:connecta_social_app/screens/settings_screen.dart';
import 'package:connecta_social_app/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'helpers/bloc_observer/bloc_observer_helper.dart';
import 'helpers/local/cache_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 AppToast.showToastMessage(message: 'WOOOOOOW', toastType: ToastType.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) { }); //app is open
  FirebaseMessaging.onMessageOpenedApp.listen((event) { }); //app is open in background
  FirebaseMessaging.onBackgroundMessage((firebaseMessagingBackgroundHandler));

  await CacheHelper.initCache();
  uid = CacheHelper.getData(key: 'uid');
  Bloc.observer = MyBlocObserver();
  Widget widget;
  if (uid != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget widget;

  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Connecta',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.teal,
          scaffoldBackgroundColor: Colors.white,
          indicatorColor: Colors.tealAccent,
          inputDecorationTheme: InputDecorationTheme().copyWith(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            labelStyle: TextStyle(
              fontFamily: 'Blueberry Sans',
              color: Colors.teal
            ),
          ),
          textTheme: TextTheme(
            button: Theme.of(context).textTheme.button!.copyWith(
                  fontFamily: 'Blueberry Sans',
                ),
            bodyText2: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontFamily: 'Blueberry Sans',
                ),
            caption: Theme.of(context).textTheme.caption!.copyWith(
                  fontFamily: 'Blueberry Sans',
                ),
          ),
          appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.teal,
                fontFamily: 'Blueberry Sans',
                fontWeight: FontWeight.w400,
                fontSize: 24),
            iconTheme: IconThemeData(color: Colors.teal),
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
            ),
            elevation: 0.0,
          ),
        ),
        home: widget,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          SocialLayout.routeName: (context) => SocialLayout(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          EditProfileScreen.routeName: (context) => EditProfileScreen(),
          AddPostScreen.routeName: (context) => AddPostScreen(),
        },
      ),
    );
  }
}
