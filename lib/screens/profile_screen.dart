import 'dart:developer';

import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/screens/edit_profile_screen.dart';
import 'package:connecta_social_app/utils/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = cubit.userModel;
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    children: [
                      Align(
                        child: (model!.cover == null)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: Colors.black26,
                                  ),
                                  width: double.infinity,
                                  height: 150,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    image: DecorationImage(
                                      image: NetworkImage(model.cover!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                        alignment: Alignment.topCenter,
                      ),
                      Positioned(
                          top: 80,
                          child: CircleAvatar(
                            radius: 53.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(model.image!),
                              radius: 50.0,
                            ),
                          )),
                    ],
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  model.name!,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  model.bio!,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 16.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('100',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),),
                        Text('Posts',style: Theme.of(context).textTheme.caption!),
                      ],
                    ),
                    Column(
                      children: [
                        Text('230',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),),
                        Text('Photos',style: Theme.of(context).textTheme.caption!),
                      ],
                    ),
                    Column(
                      children: [
                        Text('10k',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),),
                        Text('Followers',style: Theme.of(context).textTheme.caption!),
                      ],
                    ),
                    Column(
                      children: [
                        Text('64',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),),
                        Text('following',style: Theme.of(context).textTheme.caption!),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(width: 260,child: OutlinedButton(onPressed: (){}, child: Text('Add Photos'))),
                      SizedBox(width: 20.0,),
                      OutlinedButton(onPressed: (){
                        Navigator.of(context).pushNamed(EditProfileScreen.routeName);
                      }, child: Icon(IconBroken.Edit)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
