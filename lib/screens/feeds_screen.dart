import 'package:connecta_social_app/screens/profile_screen.dart';
import 'package:connecta_social_app/utils/constants.dart';
import 'package:connecta_social_app/utils/styles/icon_broken.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(onTap: (){
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              Text(
                                'Jul 1, 2021 at 11:00 pm',
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
                    Text(postText),
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
                    SizedBox(
                      height: 8.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1611771341253-dadb347165a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
                      ),
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
                        Text('120'),
                        Spacer(),
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Text('120 comments'),
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
                              'https://images.pexels.com/photos/941693/pexels-photo-941693.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                          radius: 18.0,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(height: 1.0),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
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
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(24.0)),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding:
                            const EdgeInsets.only(right: 12, bottom: 4),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              'Jul 1, 2021 at 11:00 pm',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.5),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(postText),
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
                    SizedBox(
                      height: 8.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1611771341253-dadb347165a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
                      ),
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
                        Text('120'),
                        Spacer(),
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Text('120 comments'),
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
                              'https://images.pexels.com/photos/941693/pexels-photo-941693.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                          radius: 18.0,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(height: 1.0),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
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
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(24.0)),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding:
                            const EdgeInsets.only(right: 12, bottom: 4),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              'Jul 1, 2021 at 11:00 pm',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.5),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(postText),
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
                    SizedBox(
                      height: 8.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1611771341253-dadb347165a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
                      ),
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
                        Text('120'),
                        Spacer(),
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Text('120 comments'),
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
                              'https://images.pexels.com/photos/941693/pexels-photo-941693.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                          radius: 18.0,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(height: 1.0),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
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
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(24.0)),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding:
                            const EdgeInsets.only(right: 12, bottom: 4),
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
          ),
        ],
      ),
    );
  }
}
