import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => SocialCubit.get(context).swipeToRefreshUsers(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, index) {},
        builder: (context, index) {
          var cubit = SocialCubit.get(context);
          return (cubit.users.length > 0)
              ? ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute (
                            builder: (BuildContext context) => ChatScreen(cubit.users[index]),
                          ),);
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${cubit.users[index].image}'),
                                  radius: 22.0,
                                ),
                                Positioned(
                                    top: 30.0,
                                    left: 30.0,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 8.0,
                                        child: CircleAvatar(
                                          radius: 6.0,
                                          backgroundColor: Colors
                                              .lightGreenAccent.shade700,
                                        )))
                              ],
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
                                      '${cubit.users[index].name}',
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
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: cubit.users.length)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
