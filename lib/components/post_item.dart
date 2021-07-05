import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/models/post_model.dart';
import 'package:connecta_social_app/screens/profile_screen.dart';
import 'package:connecta_social_app/utils/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostItem extends StatelessWidget {
  final int postIndex;
  PostItem(this.postIndex);
  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();
    return BlocConsumer<SocialCubit,SocialStates>(listener: (context,state){} ,builder: (context,state){
      PostModel postItem = SocialCubit.get(context).posts[postIndex];
      var cubit = SocialCubit.get(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${postItem.image}'),
                        radius: 22.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${postItem.name}',
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
                          Text(
                            '${postItem.dateTime}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.5),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text('${postItem.text}'),
                SizedBox(
                  height: 8.0,
                ),
                Wrap(
                  children: [
                    InkWell(
                      child: Text(
                        '#software',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    InkWell(
                      child: Text(
                        '#flutter',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                if(postItem.postImage != null)
                  Column(
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image(
                          image: NetworkImage(
                              '${postItem.postImage}'),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                      size: 20,
                    ),
                    Text('${SocialCubit.get(context).likes[postIndex]}'),
                    Spacer(),
                    Icon(
                      IconBroken.Chat,
                      color: Colors.amber,
                      size: 20,
                    ),
                    Text('${cubit.comments[postIndex]} comments'),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade100,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${postItem.image}'),
                      radius: 18.0,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 150,
                          child: TextField(
                            controller: commentController,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(height: 1.0),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(24.0)),
                              contentPadding: EdgeInsets.all(10.0),
                              isDense: true,
                              hintText: 'Write a comment...',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.grey)
                                  .copyWith(height: 1.3),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(24.0)),
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          SocialCubit.get(context).addComment(commentController.text, cubit.postsId[postIndex], cubit.userModel!.uid!);
                          commentController.clear();
                        }, icon: Icon(IconBroken.Send),iconSize: 30.0,color: Theme.of(context).primaryColor,)
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[postIndex]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } , );
  }
}
