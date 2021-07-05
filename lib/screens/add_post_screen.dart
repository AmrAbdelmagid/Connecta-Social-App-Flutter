import 'dart:developer';

import 'package:connecta_social_app/components/app_toast.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/utils/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add-post';

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var textController = TextEditingController();
  bool showPostImage = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text('Create Post'),
              actions: [
                TextButton(
                    onPressed: () {
                      cubit
                          .createPost(
                              text: textController.text,
                              dataTime: DateTime.now().toString(),
                              postImage: cubit.postImageUrl != null
                                  ? cubit.postImageUrl
                                  : null)
                          .then((value) {
                        if (value == true) {
                          AppToast.showToastMessage(
                              message: 'Status Updated',
                              toastType: ToastType.SUCCESS);
                          textController.clear();
                          setState(() {
                            showPostImage = false;
                          });
                          FocusScope.of(context).unfocus();
                        } else {
                          AppToast.showToastMessage(
                              message: 'Failed!', toastType: ToastType.ERROR);
                          FocusScope.of(context).unfocus();
                        }
                      }).catchError((error, s) {});
                    },
                    child: Text('Post')),
              ],
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  if (state is SocialCreatePostLoadingState ||
                      state is SocialUploadPostImageLoadingState)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: LinearProgressIndicator(),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.pexels.com/photos/941693/pexels-photo-941693.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                              radius: 22.0,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Amr Abdelmagid',
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                      size: 14.0,
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          controller: textController,
                          maxLines: null,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(height: 1.0),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                            isDense: true,
                            hintText: 'What\'s on your mind? Amr',
                            hintStyle:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.black54,
                                      height: 2,
                                    ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.pickPostImage().then((value) {
                                if (value == false) return;
                                cubit.uploadPostImage().then((value) {
                                  if (value == true) {
                                    log(value.toString());
                                    setState(() {
                                      showPostImage = true;
                                    });
                                  }
                                });
                              }).catchError((error, s) {
                                log(error.toString());
                                log(s.toString());
                              });
                            },
                            child: Row(
                              children: [
                                Icon(IconBroken.Image,
                                    color: Theme.of(context).primaryColor),
                                Text('Add Photo',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor)),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {},
                              child: Text(
                                '#Tags',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (cubit.postImage!= null && showPostImage == true)
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                  image: FileImage(cubit.postImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18.0,top: 18.0),
                              child: Container(
                                padding: EdgeInsets.only(bottom: 1),
                                height: 26.0,
                                width: 26.0,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8.0)
                                ),
                                alignment: Alignment.center,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      cubit.postImageUrl = null;
                                    });
                                  },
                                  icon: Icon(IconBroken.Close_Square,color: Colors.white,),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
