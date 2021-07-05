
import 'package:connecta_social_app/components/app_toast.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/screens/add_post_screen.dart';
import 'package:connecta_social_app/screens/settings_screen.dart';
import 'package:connecta_social_app/utils/constants.dart';
import 'package:connecta_social_app/utils/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatefulWidget {
  static const routeName = '/social-layout';

  @override
  _SocialLayoutState createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return GestureDetector(
          onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
          child: Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(IconBroken.Notification)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddPostScreen.routeName);
                    },
                    icon: Icon(IconBroken.Paper_Plus)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(IconBroken.Search)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                    icon: Icon(IconBroken.Setting),),
                 isLogout ? Center(child: Padding(
                   padding: const EdgeInsets.only(right: 18.0,left: 12.0,),
                   child: Container(height: 16,width: 16,child: CircularProgressIndicator(strokeWidth: 3,)),
                 )) :
                IconButton(
                    onPressed: () {
                      cubit.logout(context);
                      setState(() {
                        isLogout = true;
                      });

                    },
                    icon: Icon(IconBroken.Logout)),
                SizedBox(width: 1,),
              ],
            ),
            body: (cubit.userModel == null)
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      if (FirebaseAuth.instance.currentUser != null && !FirebaseAuth.instance.currentUser!.emailVerified)
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.amber.withOpacity(.6),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('Verify Your Email'),
                                Spacer(),
                                TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification();
                                      AppToast.showToastMessage(
                                          message:
                                              'Check Your Email. (It May take sometime to activate!)',
                                          toastType: ToastType.WARNING);
                                    },
                                    child: Text('Send')),
                              ],
                            ),
                          ),
                        ),
                      Expanded(child: cubit.bottomNavBarScreens[cubit.currentIndex],)
                    ],
                  ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
              ],
              onTap: (index){
                cubit.changeBottomNavBarScreen(index);
              },
            ),
          ),
        );
      },
    );
  }
}
