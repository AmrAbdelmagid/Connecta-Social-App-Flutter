import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/helpers/local/cache_helper.dart';
import 'package:connecta_social_app/models/post_model.dart';
import 'package:connecta_social_app/models/post_model.dart';
import 'package:connecta_social_app/models/post_model.dart';
import 'package:connecta_social_app/models/user_model.dart';
import 'package:connecta_social_app/screens/chats_screen.dart';
import 'package:connecta_social_app/screens/feeds_screen.dart';
import 'package:connecta_social_app/screens/login_screen.dart';
import 'package:connecta_social_app/screens/users_screen.dart';
import 'package:connecta_social_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  final picker = ImagePicker();

  File? profileImage;

  Future<dynamic> pickProfileImage() async {
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      log('No image was picked');
      return false;
    }
    profileImage = File(pickedFile.path);
    emit(SocialPickImageState());
  }

  File? coverImage;

  Future<dynamic> pickCoverImage() async {
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      log('No image was picked');
      emit(SocialPickCoverErrorState());
      return false;
    }
    coverImage = File(pickedFile.path);
    emit(SocialPickCoverSuccessState());
  }

  File? postImage;

  Future<dynamic> pickPostImage() async {
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      log('No image was picked');
      emit(SocialPickPostImageErrorState());
      return false;
    }
    postImage = File(pickedFile.path);
    emit(SocialPickPostImageSuccessState());
  }

  UserModel? userModel;
  int currentIndex = 0;

  List<Widget> bottomNavBarScreens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Users Location',
  ];

  void changeBottomNavBarScreen(int index) {
    currentIndex = index;
    emit(BottomNaVBarState());
  }

  void getUserData() async {
    emit(SocialGetUserDataLoadingState());
    try {
      if (uid == null) {
        uid = CacheHelper.getData(key: 'uid');
      }
      DocumentSnapshot<Map<String, dynamic>> response =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userModel = UserModel.fromFirebase(response.data()!);
      emit(SocialGetUserDataSuccessState());
    } catch (error, s) {
      log(error.toString());
      log(s.toString());
      emit(SocialGetUserDataErrorState());
    }
  }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await CacheHelper.removeData(key: 'uid');
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }

  String? profileImageUrl;

  uploadProfileImage() {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        log(value.toString());
        profileImageUrl = value.toString();
        emit(SocialUploadProfileSuccessState());
      }).catchError((error, s) {
        log(error.toString());
        log(s.toString());
        emit(SocialUploadProfileErrorState());
      });
    }).catchError((error, s) {
      log(error.toString());
      log(s.toString());
      emit(SocialUploadProfileErrorState());
    });
  }

  String? coverImageUrl;

  uploadCoverImage() {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        log(value.toString());
        coverImageUrl = value.toString();
        emit(SocialUploadCoverSuccessState());
      }).catchError((error, s) {
        log(error.toString());
        log(s.toString());
        emit(SocialUploadCoverErrorState());
      });
    }).catchError((error, s) {
      log(error.toString());
      log(s.toString());
      emit(SocialUploadCoverErrorState());
    });
  }

  String? postImageUrl;

  Future<bool> uploadPostImage() {
    emit(SocialUploadPostImageLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      return value.ref.getDownloadURL().then((value) {
        log(value.toString());
        postImageUrl = value.toString();
        emit(SocialPickPostImageSuccessState());
        return true;
      }).catchError((error, s) {
        log(error.toString());
        log(s.toString());
        emit(SocialPickPostImageErrorState());
        return false;
      });
    }).catchError((error, s) {
      log(error.toString());
      log(s.toString());
      emit(SocialPickPostImageErrorState());
      return false;
    });
  }

  updateUser({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserDataLoadingState());
    if (profileImageUrl != null && coverImageUrl != null) {
      updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: coverImageUrl,
          image: profileImageUrl);
    } else if (profileImageUrl != null && coverImageUrl == null) {
      updateUserData(
          name: name, phone: phone, bio: bio, image: profileImageUrl);
    } else if (profileImageUrl == null && coverImageUrl != null) {
      updateUserData(name: name, phone: phone, bio: bio, cover: coverImageUrl);
    } else {
      updateUserData(name: name, phone: phone, bio: bio);
    }
  }

  updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
        name: name,
        email: FirebaseAuth.instance.currentUser!.email,
        phone: phone,
        bio: bio,
        cover: cover ?? userModel!.cover,
        image: image ?? userModel!.image,
        uid: FirebaseAuth.instance.currentUser!.uid,
        isEmailVerified: FirebaseAuth.instance.currentUser!.emailVerified);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error, s) {
      log(error.toString());
      log(s.toString());
      emit(SocialUpdateUserDataErrorState());
    });
  }

  Future<bool> createPost({
    required String text,
    required String dataTime,
    String? name,
    String? uid,
    String? image,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      dateTime: dataTime,
      text: text,
      postImage: postImage ?? null,
      image: userModel!.image,
      uid: FirebaseAuth.instance.currentUser!.uid,
    );
    return FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      return true;
    }).catchError((error, s) {
      emit(SocialCreatePostErrorState());
      return false;
    });
  }

  // getComments(int postIndex) {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postsId[postIndex])
  //       .collection('comments')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //      // postComments.add(element.data()[postsId[postIndex]]);
  //      log(element.data()[userModel!.uid]);
  //     });
  //   }).catchError((error, s) {});
  // }

  List<String> postsId = [];
  List<PostModel> posts = [];
  List<int> likes = [];
  List<int> comments = [];
  List<String> postComments = [];

  getPosts() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('likes')
            .get()
            .then((value) {
              likes.add(value.docs.length);
            })
            .then((value) {
              element.reference.collection('comments').get().then((value) {
                comments.add(value.docs.length);
              }).then((value) {
                postsId.add(element.id);
                posts.add(PostModel.fromFirebase(element.data()));
                emit(SocialGetPostSuccessState());
              });
            })
            .then((value) {})
            .catchError((error, s) {});
      });
    }).catchError((error, s) {
      emit(SocialGetPostErrorState());
    });
  }

  likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  addComment(String comment, String postId, String userId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      userId: comment,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }
}
