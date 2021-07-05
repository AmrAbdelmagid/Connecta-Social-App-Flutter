import 'dart:developer';

import 'package:connecta_social_app/components/default_text_field.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/utils/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = cubit.userModel;
        nameController.text = model!.name!;
        phoneController.text = model.phone!;
        bioController.text = model.bio!;
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Edit Profile'),
              titleSpacing: 0.0,
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    },
                    child: Text('UPDATE')),
                SizedBox(
                  width: 2,
                )
              ],
            ),
            body: Stack(
              children: [
                if (state is SocialUpdateUserDataLoadingState)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: LinearProgressIndicator(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: 190,
                          child: Stack(
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    child: (model.cover == null)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
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
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                image: DecorationImage(
                                                  image: cubit.coverImage ==
                                                          null
                                                      ? NetworkImage(
                                                          model.cover!)
                                                      : FileImage(
                                                              cubit.coverImage!)
                                                          as ImageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                    alignment: Alignment.topCenter,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20),
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          child: IconButton(
                                            icon: Icon(IconBroken.Camera),
                                            onPressed: () {
                                              cubit
                                                  .pickCoverImage()
                                                  .then((value) {
                                                    if (value == false){
                                                      return;
                                                    }
                                                cubit.uploadCoverImage();
                                              }).catchError((error, s) {
                                                log(error.toString());
                                              });
                                            },
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 80,
                                child: CircleAvatar(
                                  radius: 53.0,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            cubit.profileImage == null
                                                ? NetworkImage(model.image!)
                                                : FileImage(cubit.profileImage!)
                                                    as ImageProvider,
                                        radius: 50.0,
                                      ),
                                      Positioned(
                                          top: 60,
                                          left: 60,
                                          child: CircleAvatar(
                                            child: IconButton(
                                              icon: Icon(IconBroken.Camera),
                                              onPressed: () {
                                                cubit
                                                    .pickProfileImage()
                                                    .then((value) {
                                                      if (value == false){
                                                        return;
                                                      }
                                                  cubit.uploadProfileImage();
                                                }).catchError((error, s) {
                                                  log(error.toString());
                                                });
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              DefaultTextFormField(
                                label: 'Name',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name must not be empty';
                                  }
                                  return null;
                                },
                                controller: nameController,
                                prefixIconData: IconBroken.User,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              DefaultTextFormField(
                                label: 'Phone',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone must not be empty';
                                  }
                                  return null;
                                },
                                controller: phoneController,
                                prefixIconData: IconBroken.Call,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              DefaultTextFormField(
                                label: 'Bio',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Bio must not be empty';
                                  }
                                  return null;
                                },
                                controller: bioController,
                                prefixIconData: IconBroken.Info_Circle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
